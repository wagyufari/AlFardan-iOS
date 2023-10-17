//
//  UIView+Extension.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

extension UIView {
    func reloadView() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
