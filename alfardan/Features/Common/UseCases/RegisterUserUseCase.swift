//
//  RegisterUserUseCase.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

struct RegisterUserUseCase {
    
    let authRepository: AuthRepository
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func invoke(email: String, password: String, completionHandler: @escaping (Result<User, Error>) -> Void) {
        authRepository.registerUser(email: email, password: password, completion: completionHandler)
    }
    
}
