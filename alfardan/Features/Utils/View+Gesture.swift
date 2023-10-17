//
//  View+Gesture.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func onTap(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer { gesture in
            handler(gesture as! UITapGestureRecognizer)
        }
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
}

extension UIGestureRecognizer {
    fileprivate var handler: GestureRecognizerClosureHandler! {
        get { return objc_getAssociatedObject(self, "gesture_handler") as? GestureRecognizerClosureHandler }
        set { objc_setAssociatedObject(self, "gesture_handler", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    convenience init(handler: @escaping (UIGestureRecognizer) -> Void) {
        let handler = GestureRecognizerClosureHandler(handler: handler)
        self.init(target: handler, action: #selector(GestureRecognizerClosureHandler.handleGesture(_:)))
        self.handler = handler
    }
}

class GestureRecognizerClosureHandler: NSObject {
    fileprivate let handler: (UIGestureRecognizer) -> Void
    init(handler: @escaping (UIGestureRecognizer) -> Void) { self.handler = handler }
    @objc func handleGesture(_ gestureRecognizer: UIGestureRecognizer) { handler(gestureRecognizer) }
}
