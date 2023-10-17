//
//  AuthRepository.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import Alamofire

class AuthRepository {
    
    private let apiLogin = "https://mocki.io/v1/a67e09fc-efdf-4530-b6c6-293ce13856cb"
    private let apiRegister = "https://mocki.io/v1/a67e09fc-efdf-4530-b6c6-293ce13856cb"
    
    func authenticateUser(email: String, password: String, completion: @escaping (Result<UserResponseModel, Error>) -> Void) {
        
        APIClient.shared.performRequest(apiLogin, decodingType: UserResponseModel.self, completion: completion)
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        APIClient.shared.performRequest(apiRegister, decodingType: User.self, completion: completion)
    }
}
