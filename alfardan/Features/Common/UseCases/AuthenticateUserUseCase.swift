//
//  AuthenticateUserUseCase.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

struct AuthenticateUserUseCase {
    
    let authRepository: AuthRepository
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func invoke(email: String, password: String, completionHandler: @escaping (Result<User?, Error>) -> Void) {
        authRepository.authenticateUser(email: email, password: password) { result in
            completionHandler(result.map({ user in
                let saved = KeychainService.save(token: user.token ?? "", forKey: .AccessToken)
                if saved {
                    Notification.send(.AccessToken)
                }
                return user.user
            }))
        }
    }
    
}
