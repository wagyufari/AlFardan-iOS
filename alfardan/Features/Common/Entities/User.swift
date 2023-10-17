//
//  User.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

struct UserResponseModel: Codable {
    let token: String?
    let user: User?
}

struct User: Codable {
    let id: String?
    let email: String?
    let name: String?
    let balance: String?
    let profilePicture: String?
}
