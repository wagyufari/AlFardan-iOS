//
//  Keyboard+Utils.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import ReactiveSwift

class Keyboard {
    
    static func dismiss(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    static func observeKeyboardChanges(onShow: @escaping (CGFloat) -> Void, onHide: @escaping  ()->Void) {
        let keyboardWillShowSignal = NotificationCenter.default.reactive.notifications(forName: UIResponder.keyboardWillShowNotification)
        let keyboardWillHideSignal = NotificationCenter.default.reactive.notifications(forName: UIResponder.keyboardWillHideNotification)
        
        keyboardWillShowSignal
            .flatMap(.latest) { notification -> SignalProducer<CGFloat, Never> in
                if let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return SignalProducer(value: keyboardFrame.height)
                } else {
                    return SignalProducer.empty
                }
            }
            .observe(on: UIScheduler())
            .observeValues { height in
                onShow(height)
            }
        
        keyboardWillHideSignal
            .observe(on: UIScheduler())
            .observeValues { _ in
                onHide()
            }
    }
}
