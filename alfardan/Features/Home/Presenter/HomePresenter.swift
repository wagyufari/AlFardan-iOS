//
//  HomePresenter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI
import ReactiveSwift
import RxSwift
import RxCocoa

class HomePresenter: ObservableObject {
    
    var view: HomeViewController?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    var isLoading = MutableProperty(false)
    
    func viewDidLoad() {
        view?.view = HomeView(presenter: self)
    }
    
    func didFetchUsers() {
        isLoading.value = true
        interactor?.fetchUsers()
    }
    
    func didTapUser(user: User) {
        router?.navigateToSendMoney(from: view, user: user)
    }
    
    func didTapSignOut() {
        KeychainService.deleteToken(forKey: .AccessToken)
        Notification.send(.AccessToken)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func didLoadUsers(users: [User]) {
        isLoading.value = false
        self.users.accept(users)
    }
    
    func didFail(error: String) {
        SnackBar.show(message: error)
    }
    
   
}
