//
//  Typography.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import SwiftUI

enum Typography {
    case title1
    case title2
    case title3
    case title4
    case title5
    case title6
    case body
    case body2
    case caption
    
    var font: UIFont {
        switch self {
        case .title1:
            return .systemFont(ofSize: 28, weight: .bold)
        case .title2:
            return .systemFont(ofSize: 24, weight: .medium)
        case .title3:
            return .systemFont(ofSize: 20, weight: .medium)
        case .title4:
            return .systemFont(ofSize: 16, weight: .medium)
        case .title5:
            return .systemFont(ofSize: 14, weight: .medium)
        case .title6:
            return .systemFont(ofSize: 12, weight: .medium)
        case .body:
            return .systemFont(ofSize: 16, weight: .regular)
        case .body2:
            return .systemFont(ofSize: 14, weight: .regular)
        case .caption:
            return .systemFont(ofSize: 12, weight: .regular)
        }
    }
    
}


extension UILabel {
    func setTheme(typography: Typography) {
        self.font = typography.font
    }
}

extension Text {
    func theme(_ style: Typography) -> Text {
        return self.font(Font(style.font))
    }
}


extension UITextField {
    func setTheme(typography: Typography) {
        self.font = typography.font
    }
}
