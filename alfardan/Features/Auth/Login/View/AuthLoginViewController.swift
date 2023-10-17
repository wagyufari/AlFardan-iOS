//
//  AuthLoginViewController.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import PinLayout
import SwiftUI
import ReactiveSwift
import ReactiveCocoa

class AuthLoginViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var presenter: AuthLoginPresenter?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class AuthLoginView: UIView {
    
    var presenter: AuthLoginPresenter
    
    let logoImage = UIImageView()
    let titleLabel = UILabel()
    
    let emailTextField = AuthTextField(hint: "Email Address", type: .Email)
    let passwordTextField = AuthTextField(hint: "Password", type: .Password)
    
    let submitLabel = UILabel()
    let submitContainer = UIView()
    
    let registerLabel = UILabel()
    
    let progressView = UIActivityIndicatorView()
    
    let container = UIView()
    
    var keyboardHeight: CGFloat = 0 {
        didSet{
            reloadView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: AuthLoginPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        addSubview(container)
        container.addSubview(logoImage)
        container.addSubview(titleLabel)
        
        container.addSubview(emailTextField)
        container.addSubview(passwordTextField)
        
        container.addSubview(submitContainer)
        submitContainer.addSubview(submitLabel)
        
        container.addSubview(registerLabel)
        
        container.addSubview(progressView)
        
        backgroundColor = .white
        
        Keyboard.observeKeyboardChanges { height in
            self.keyboardHeight = height
        } onHide: {
            self.keyboardHeight = 0
        }

        progressView.startAnimating()
        emailTextField.textField.reactive.text <~ presenter.email
        passwordTextField.textField.reactive.text <~ presenter.password
        progressView.reactive.isHidden <~ presenter.isLoading.map({ !$0 })
        submitContainer.reactive.isHidden <~ presenter.isLoading
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.horizontally()
        
        logoImage.image = UIImage(named: "logo_white")?.withRenderingMode(.alwaysTemplate)
        logoImage.tintColor = .primaryColor
        
        titleLabel.text = "Welcome to Al-Fardan"
        titleLabel.setTheme(typography: .title1)
        titleLabel.textColor = .textPrimary
        
        submitLabel.setTheme(typography: .body2)
        submitLabel.textColor = .white
        submitLabel.text = "Login"
        submitContainer.backgroundColor = .primaryColor
        submitContainer.layer.cornerRadius = 4
        
        submitContainer.onTap { _ in
            self.presenter.didTapLogin()
        }
        
        registerLabel.onTap { _ in
            self.presenter.didTapSignUp()
        }
        
        registerLabel.attributedText = noAccountString()
        
        logoImage.pin.height(150).width(150).hCenter()
        titleLabel.pin.below(of: logoImage).sizeToFit().hCenter().marginTop(16)
        
        emailTextField.pin.below(of: titleLabel).marginTop(16)
        emailTextField.reloadView()
        passwordTextField.pin.below(of: emailTextField).marginTop(8)
        passwordTextField.reloadView()
        
        submitContainer.pin.below(of: passwordTextField).horizontally(64).marginTop(16)
        submitLabel.pin.sizeToFit().hCenter()
        submitContainer.pin.wrapContent(.vertically, padding: 12)
        
        progressView.pin.below(of: passwordTextField).wrapContent().hCenter().marginTop(12)
        
        registerLabel.pin.below(of: submitContainer).sizeToFit().marginTop(12).hCenter()
        
        if keyboardHeight == 0 {
            container.pin.wrapContent(.vertically).center()
        } else {
            container.pin.wrapContent(.vertically).bottom(keyboardHeight + 16)
        }
        
        onTap { _ in
            Keyboard.dismiss()
        }
    }
    
    func noAccountString() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        let donTHaveAccountText = NSAttributedString(string: "Don't have an account? ", attributes: [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.textTertiary
        ])

        let signUpText = NSAttributedString(string: "Sign up", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.primaryColor
        ])
        
        attributedText.append(donTHaveAccountText)
        attributedText.append(signUpText)
        return attributedText
    }
}

//struct AuthLoginView: View{
//
//    @StateObject var presenter: AuthLoginPresenter
//
//    var body: some View {
//        VStack(spacing: 16){
//            Image("logo_white")
//                .resizable()
//                .renderingMode(.template)
//                .foregroundStyle(Color.primaryColor)
//                .frame(width: 150, height: 150)
//            (Text("Welcome to ")
//                .theme(.title1)
//                .foregroundStyle(Color.textPrimary) + Text("Al-Fardan")
//                .theme(.title1)
//                .foregroundStyle(Color.primaryColor))
//            AuthTextField(text: $presenter.email, hint: "Email", type: .Email)
//            AuthTextField(text: $presenter.password, hint: "Password", type: .Password)
//            if presenter.isLoading {
//                ProgressView()
//            } else {
//                Text("Login")
//                    .theme(.body)
//                    .foregroundStyle(Color.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 16)
//                    .background(Color.primaryColor)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                    .onTapGesture {
//                        presenter.didTapLogin()
//                        Keyboard.dismiss()
//                    }
//            }
//            (Text("Don't have an account? ")
//                .theme(.body2)
//                .foregroundStyle(Color.textTertiary) + Text("Sign up").theme(.title5).foregroundStyle(Color.primaryColor))
//            .onTapGesture {
//                presenter.didTapSignUp()
//            }
//        }
//        .padding(.horizontal, 32)
//        .animation(Animation.easeIn(duration: 0.2))
//        .frame(maxHeight: .infinity)
//        .background(Color.white)
//        .onTapGesture {
//            Keyboard.dismiss()
//        }
//    }
//
//}
