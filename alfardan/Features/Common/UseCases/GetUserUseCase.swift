//
//  GetUserUseCase.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

struct GetUserUseCase {
    
    let userRepository: UserRepository
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func invoke(completionHandler: @escaping (Result<[User], Error>) -> Void) {
        userRepository.fetchUsers(completion: completionHandler)
    }
    
}
