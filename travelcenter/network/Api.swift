//
//  Api.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation
import Alamofire

struct Api {
    
    static let shared = Api()
    
    func doRequest(
        endpoint: Endpoint,
        onSuccess: @escaping (_ model: Any?) -> Void,
        onFailure: @escaping (_ message: String) -> Void
    ) {
        switch (endpoint.method) {
        case .get:
            doGetRequest(
                endpoint: endpoint, 
                completion: { apiResponse in
                    switch(apiResponse) {
                    case .Success(data: let model):
                        onSuccess(model)
                    case .Error(message: let message):
                        onFailure(message)
                    }
                }
            )
        case .post:
            doPostRequest(
                endpoint: endpoint,
                completion: { apiResponse in
                    switch(apiResponse) {
                    case .Success(data: let model):
                        onSuccess(model)
                    case .Error(message: let message):
                        onFailure(message)
                    }
                }
            )
        case .delete:
            doDeleteRequest(
                endpoint: endpoint,
                completion: { apiResponse in
                    switch(apiResponse) {
                    case .Success(data: let model):
                        onSuccess(model)
                    case .Error(message: let message):
                        onFailure(message)
                    }
                }
            )
        default:
            onFailure("Método HTTP não mapeado.")
        }
    }
    
    private func doGetRequest(
        endpoint: Endpoint,
        completion: @escaping (_ apiResponse: ApiResponse) -> Void
    ) {
        Task {
            getHeaders(endpoint: endpoint, completion: { headers in
                Alamofire.AF.request(
                    endpoint.endpoint,
                    headers: headers
                ).responseData { responseData in
                    completion(
                        handleResponse(data: responseData, endpoint: endpoint)
                    )
                }
            })
        }
    }
    
    private func doPostRequest(
        endpoint: Endpoint,
        completion: @escaping (_ apiResponse: ApiResponse) -> Void
    ) {
        if let parameters = endpoint.parameters {
            Task {
                getHeaders(endpoint: endpoint, completion: { headers in
                    Alamofire.AF.request(
                        endpoint.endpoint,
                        method: .post,
                        parameters: parameters,
                        encoder: JSONParameterEncoder.default,
                        headers: headers
                    ).responseData { responseData in
                        completion(
                            handleResponse(data: responseData, endpoint: endpoint)
                        )
                    }
                })
            }
        } else {
            completion(
                ApiResponse.Error(message: "Requisição sem parâmetros")
            )
        }
    }
    
    private func doDeleteRequest(
        endpoint: Endpoint,
        completion: @escaping (_ apiResponse: ApiResponse) -> Void
    ) {
        Task {
            getHeaders(endpoint: endpoint, completion: { headers in
                Alamofire.AF.request(
                    endpoint.endpoint,
                    method: .delete,
                    headers: headers
                ).responseData { responseData in
                    completion(
                        handleResponse(data: responseData, endpoint: endpoint)
                    )
                }
            })
        }
    }
    
    private func getHeaders(endpoint: Endpoint, completion: @escaping (HTTPHeaders?) -> Void) {
        if (endpoint.authenticated) {
            if let token = CoreDataManager.shared.getUserToken() {
                completion(
                    HTTPHeaders(dictionaryLiteral: ("Authorization", "Bearer \(token)"))
                )
            } else {
                let user = CoreDataManager.shared.getLoginData()
                doRequest(
                    endpoint: .doLogin(data: LoginModel(email: user.email, password: user.password)),
                    onSuccess: { model in
                        let userModel = model as! UserModel
                        UserManager.saveUser(model: userModel, password: user.password)
                        completion(
                            HTTPHeaders(dictionaryLiteral: ("Authorization", "Bearer \(userModel.token)"))
                        )
                    }, onFailure: { error in
                        completion(nil)
                    }
                )
            }
        } else {
            completion(nil)
        }
    }
    
    private func handleResponse(data: AFDataResponse<Data>, endpoint: Endpoint) -> ApiResponse {
        return if (isSuccess(data)) {
            handleSuccess(data.data, endpoint: endpoint)
        } else {
            handleError(data.data)
        }
    }
    
    private func isSuccess(_ responseData: AFDataResponse<Data>) -> Bool {
        return responseData.response?.statusCode == 200
    }
    
    private func handleSuccess(_ data: Data?, endpoint: Endpoint) -> ApiResponse {
        var model: Codable? = nil
        if let data, let decodeType = endpoint.responseType {
            model = try! JSONDecoder().decode(decodeType, from: data)
        }
        return if (model is ArrayType) {
             ApiResponse.Success(data: model as? [CodableModel])
        } else {
            ApiResponse.Success(data: model as? CodableModel)
        }
    }
    
    private func handleError(_ data: Data?) -> ApiResponse {
        if let errorData = data {
            let model: ApiError = try! JSONDecoder().decode(ApiError.self, from: errorData)
            return ApiResponse.Error(message: model.detail)
        } else {
            return ApiResponse.Error(message: "Ocorreu um erro inesperado.")
        }
    }
}
