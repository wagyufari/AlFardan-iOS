//
//  AuthRegisterProtocols.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI

protocol AuthRegisterInteractorOutputProtocol: AnyObject {
    func didRegisterSuccess()
    func didRegisterFailed(error: String)
}

protocol AuthRegisterInteractorInputProtocol: AnyObject {
    var presenter: AuthRegisterInteractorOutputProtocol? { get set }
    
    func registerUser(email: String, password: String)
}

protocol AuthRegisterRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToLogin(from: UIViewController?)
}
