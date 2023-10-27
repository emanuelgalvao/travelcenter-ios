//
//  Validations.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 26/10/23.
//

import Foundation

struct Validations {
    
    static let MINIMUM_NAME_SIZE = 3
    static let MINIMUM_PASSWORD_SIZE = 5
    static let MINIMUM_DESCRIPTION_SIZE = 10
    static let MAXIMUM_DESCRIPTION_SIZE = 250
    static let MINIMUM_STARS = 1
    static let MAXIMUM_STARS = 5
    
    static func isValidName(_ name: String) -> Bool {
        return name.count >= MINIMUM_NAME_SIZE
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        
        var isValid = true
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(
                in: email,
                range: NSRange(location: 0, length: nsString.length)
            )
            if results.count == 0 {
                isValid = false
            }
        } catch {
            isValid = false
        }
        
        return isValid
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= MINIMUM_PASSWORD_SIZE
    }
    
    static func isPasswordEquals(
        _ password: String,
        _ confirmPassword: String
    ) -> Bool {
        return password == confirmPassword
    }
    
    static func isValidRatingDescription(_ description: String) -> Bool {
        return description.count >= MINIMUM_DESCRIPTION_SIZE &&
        description.count <= MAXIMUM_DESCRIPTION_SIZE
    }
    
    static func isValidRatingRate(_ rate: Int) -> Bool {
        return rate >= MINIMUM_STARS && rate <= MAXIMUM_STARS
    }
}
