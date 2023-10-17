//
//  SendMoneyRouter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

class SendMoneyRouter: SendMoneyRouterProtocol {
    
    static func createModule(user: User) -> UIViewController {
        
        let router = SendMoneyRouter()
        
        let view = SendMoneyViewController()
        let presenter = SendMoneyPresenter(user: user)
        let interactor = SendMoneyInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
}
