//
//  HomeRouter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    
    static func createModule() -> UIViewController {
        
        var router = HomeRouter()
        
        var view = HomeViewController()
        var presenter = HomePresenter()
        var interactor = HomeInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        return view
    }
    
    func navigateToSendMoney(from: UIViewController?, user: User) {
        from?.navigationController?.pushViewController(SendMoneyRouter.createModule(user: user), animated: true)
    }
}
