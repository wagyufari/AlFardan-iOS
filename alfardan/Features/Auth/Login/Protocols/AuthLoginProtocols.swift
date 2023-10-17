//
//  AuthLoginProtocols.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI

protocol AuthLoginInteractorOutputProtocol: AnyObject {
    func didLoginSuccess()
    func didLoginFailed(error: String)
}

protocol AuthLoginInteractorInputProtocol: AnyObject {
    var presenter: AuthLoginInteractorOutputProtocol? { get set }
    
    func authenticateUser(email: String, password: String)
}

protocol AuthLoginRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToHome(from: UIViewController?)
    func navigateToRegister(from: UIViewController?)
}
