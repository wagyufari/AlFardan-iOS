//
//  AuthRegisterRouter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

class AuthRegisterRouter: AuthRegisterRouterProtocol {
    
    static func createModule() -> UIViewController {
        
        var router = AuthRegisterRouter()
        
        var view = AuthRegisterViewController()
        var presenter = AuthRegisterPresenter()
        var interactor = AuthRegisterInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToLogin(from: UIViewController?) {
        from?.navigationController?.popViewController(animated: true)
    }
    
}
