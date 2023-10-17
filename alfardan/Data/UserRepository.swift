//
//  UserRepository.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import Alamofire

class UserRepository {
    
    private let apiUser = "https://652e22eaf9afa8ef4b2813ae.mockapi.io/user"
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        APIClient.shared.performRequest(apiUser, decodingType: [User].self, completion: completion)
    }
}
