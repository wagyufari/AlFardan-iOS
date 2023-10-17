//
//  AuthLoginInteractor.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

class AuthLoginInteractor: AuthLoginInteractorInputProtocol {
    
    var presenter: AuthLoginInteractorOutputProtocol?
    
    func authenticateUser(email: String, password: String) {
        // Ignore the delay, just for UI testing purposes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            AuthenticateUserUseCase(authRepository: AuthRepository()).invoke(email: email, password: password) { result in
                switch result {
                case .success(let user):
                    self.presenter?.didLoginSuccess()
                case .failure(let error):
                    print(error)
                    self.presenter?.didLoginFailed(error: error.localizedDescription)
                }
            }
        }
    }
}
