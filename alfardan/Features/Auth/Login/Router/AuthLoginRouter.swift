//
//  AuthLoginRouter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

class AuthLoginRouter: AuthLoginRouterProtocol {
    
    static func createModule() -> UIViewController {
        
        var router = AuthLoginRouter()
        
        var view = AuthLoginViewController()
        var presenter = AuthLoginPresenter()
        var interactor = AuthLoginInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToHome(from: UIViewController?) {
        
    }
    
    func navigateToRegister(from: UIViewController?) {
        from?.navigationController?.pushViewController(AuthRegisterRouter.createModule(), animated: true)
    }
}
