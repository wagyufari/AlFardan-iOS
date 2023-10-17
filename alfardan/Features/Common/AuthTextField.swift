//
//  AuthTextField.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import PinLayout
import UIKit
import RxCocoa
import RxSwift
import ReactiveSwift

class AuthTextField: UIView {
    
    let hint: String
    let type: AuthTextFieldType
    
    let textField = UITextField()
    let textFieldIcon = UIImageView()
    let textFieldContainer = UIView()
    
    var isFieldFocused: Bool = false {
        didSet {
            reloadView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(hint: String, type: AuthTextFieldType) {
        self.hint = hint
        self.type = type
        super.init(frame: .zero)
        addSubview(textFieldContainer)
        textFieldContainer.addSubview(textField)
        textFieldContainer.addSubview(textFieldIcon)
        
        textField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .map { [unowned textField] in
                return textField.isFirstResponder
            }
            .subscribe(onNext: { isFocused in
                self.isFieldFocused = isFocused
            })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pin.horizontally(32)
        
        textField.placeholder = hint
        textField.isSecureTextEntry = type == .Password
        textFieldIcon.image = UIImage(named: type.image())?.withRenderingMode(.alwaysTemplate)
        textFieldIcon.tintColor = isFieldFocused ? UIColor.primaryColor : UIColor.textTertiary
        
        textFieldContainer.layer.cornerRadius = 8
        textFieldContainer.layer.borderWidth = 1
        textFieldContainer.layer.borderColor = isFieldFocused ? UIColor.primaryColor.cgColor : UIColor.textTertiary.cgColor
        
        textFieldContainer.pin.horizontally(32)
        textFieldIcon.pin.height(24).width(24).left(12)
        textField.pin.left(to: textFieldIcon.edge.right).right(12).sizeToFit(.width).marginLeft(8)
        textFieldContainer.pin.wrapContent(.vertically, padding: 12)
        
        pin.wrapContent(.vertically)
    }
}

//struct AuthTextField: View {
//    
//    @Binding var text: String
//    let hint: String
//    let type: AuthTextFieldType
//    @FocusState private var isFocus: Bool
//    
//    var body: some View{
//        HStack(spacing: 8){
//            Image(type.image())
//                .resizable()
//                .renderingMode(.template)
//                .foregroundStyle(isFocus ? Color.primaryColor : Color.textTertiary)
//                .frame(width: 24, height: 24)
//            TextField(text: $text) {
//                Text(hint)
//            }
//            .focused($isFocus)
//        }
//        .padding(12)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .overlay {
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(isFocus ? Color.primaryColor : Color.textTertiary, lineWidth: 1)
//        }
//    }
//}

enum AuthTextFieldType {
    case Email
    case Password
}

extension AuthTextFieldType {
    func image() -> String {
        switch self {
        case .Email:
            return "ico-person"
        case .Password:
            return "ico-lock"
        }
    }
    
}
