//
//  AuthRegisterInteractor.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

class AuthRegisterInteractor: AuthRegisterInteractorInputProtocol {
    
    var presenter: AuthRegisterInteractorOutputProtocol?

    func registerUser(email: String, password: String) {
        // Ignore the delay, just for UI testing purposes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            RegisterUserUseCase(authRepository: AuthRepository()).invoke(email: email, password: password) { result in
                switch result {
                case .success(let user):
                    self.presenter?.didRegisterSuccess()
                case .failure(let error):
                    self.presenter?.didRegisterFailed(error: error.localizedDescription)
                }
            }
        }
    }
}
