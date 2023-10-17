//
//  Color+Extension.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    static var primaryColor = UIColor(hex: "#439232")
    static let textPrimary = UIColor (red : 15.0/255, green : 23.0/255, blue : 42.0/255, alpha : 1.0)
    static let textSecondary = UIColor (red : 71.0/255, green : 85.0/255, blue : 105.0/255, alpha : 1.0)
    static let textTertiary = UIColor (red : 148.0/255, green : 163.0/255, blue : 184.0/255, alpha : 1.0)
}

extension Color {
    static var primaryColor = Color(UIColor(hex: "#439232"))
    static let textPrimary = Color(UIColor (red : 15.0/255, green : 23.0/255, blue : 42.0/255, alpha : 1.0))
    static let textSecondary = Color(UIColor(red : 71.0/255, green : 85.0/255, blue : 105.0/255, alpha : 1.0))
    static let textTertiary = Color(UIColor (red : 148.0/255, green : 163.0/255, blue : 184.0/255, alpha : 1.0))
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
