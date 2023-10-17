//
//  HomeProtocols.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI

protocol HomeInteractorOutputProtocol: AnyObject {
    func didLoadUsers(users: [User])
    func didFail(error: String)
}

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? { get set }
    
    func fetchUsers()
}

protocol HomeRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToSendMoney(from: UIViewController?, user: User)
}
