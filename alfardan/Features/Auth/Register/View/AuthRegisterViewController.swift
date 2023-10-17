//
//  AuthRegisterViewController.swift
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

class AuthRegisterViewController: UIViewController {
    
    var presenter: AuthRegisterPresenter?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
}


class AuthRegisterView: UIView {
    
    var presenter: AuthRegisterPresenter
    
    let logoImage = UIImageView()
    let titleLabel = UILabel()
    
    let emailTextField = AuthTextField(hint: "Email Address", type: .Email)
    let passwordTextField = AuthTextField(hint: "Password", type: .Password)
    
    let submitLabel = UILabel()
    let submitContainer = UIView()
    
    let signInLabel = UILabel()
    
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
    
    init(presenter: AuthRegisterPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        addSubview(container)
        container.addSubview(logoImage)
        container.addSubview(titleLabel)
        
        container.addSubview(emailTextField)
        container.addSubview(passwordTextField)
        
        container.addSubview(submitContainer)
        submitContainer.addSubview(submitLabel)
        
        container.addSubview(signInLabel)
        
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
        
        titleLabel.text = "Create a new account"
        titleLabel.setTheme(typography: .title1)
        titleLabel.textColor = .textPrimary
        
        submitLabel.setTheme(typography: .body2)
        submitLabel.textColor = .white
        submitLabel.text = "Register"
        submitContainer.backgroundColor = .primaryColor
        submitContainer.layer.cornerRadius = 4
        
        submitContainer.onTap { _ in
            self.presenter.didTapRegister()
        }
        
        signInLabel.onTap { _ in
            self.presenter.didTapLogin()
        }
        
        signInLabel.attributedText = noAccountString()
        
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
        
        signInLabel.pin.below(of: submitContainer).sizeToFit().marginTop(12).hCenter()
        
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

        let donTHaveAccountText = NSAttributedString(string: "Already have an account? ", attributes: [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.textTertiary
        ])

        let signUpText = NSAttributedString(string: "Sign in", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.primaryColor
        ])
        
        attributedText.append(donTHaveAccountText)
        attributedText.append(signUpText)
        return attributedText
    }
}
