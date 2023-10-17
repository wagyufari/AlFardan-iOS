//
//  AuthLoginPresenter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI
import ReactiveSwift

class AuthLoginPresenter: ObservableObject {
    
    var view: AuthLoginViewController?
    var interactor: AuthLoginInteractorInputProtocol?
    var router: AuthLoginRouterProtocol?
    
    var email = MutableProperty("wagyufari@gmail.com")
    var password = MutableProperty("Password01")
    var isLoading = MutableProperty(false)
    
    func didTapLogin() {
        if email.value.isEmpty {
            SnackBar.show(message: "Email cannot be empty")
            return
        }
        
        if !isValidEmail(email.value) {
            SnackBar.show(message: "Invalid email format")
            return
        }
        
        if password.value.isEmpty {
            SnackBar.show(message: "Password cannot be empty")
            return
        }
        
        isLoading.value = true
        interactor?.authenticateUser(email: email.value, password: password.value)
    }
    
    func didTapSignUp(){
        router?.navigateToRegister(from: view)
    }
    
    func viewDidLoad() {
        view?.view = AuthLoginView(presenter: self)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // You can use a regular expression to validate the email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

extension AuthLoginPresenter: AuthLoginInteractorOutputProtocol {
    
    func didLoginSuccess() {
        isLoading.value = false
        router?.navigateToHome(from: view)
    }
    
    func didLoginFailed(error: String) {
        isLoading.value = false
        SnackBar.show(message: error)
    }
}
