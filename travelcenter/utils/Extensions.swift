//
//  Extensions.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 19/10/23.
//

import Foundation
import SwiftUI

extension View {
    
    var smallSpace: CGFloat {
        get { return 8 }
    }
    
    var mediumSpace: CGFloat {
        get { return 16 }
    }
    
    var defaultCornerRadius: CGFloat {
        get { return 8 }
    }
    
    var maxWidthWithPadding: CGFloat {
        get { return UIScreen.main.bounds.size.width - (mediumSpace * 2) }
    }
    
    var maxWidth: CGFloat {
        get { return UIScreen.main.bounds.size.width }
    }
    
    var maxHeight: CGFloat {
        get { return UIScreen.main.bounds.size.height }
    }
    
    var largeImageSize: CGFloat {
        get { return 100 }
    }
    
    var largeImageScale: CGFloat {
        get { return 4 }
    }
}

protocol ArrayType {}
extension Array : ArrayType {}
