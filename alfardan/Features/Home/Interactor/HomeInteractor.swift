//
//  HomeInteractor.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    var presenter: HomeInteractorOutputProtocol?
    
    func fetchUsers() {
        GetUserUseCase(userRepository: UserRepository()).invoke { result in
            switch result {
            case .success(let users):
                self.presenter?.didLoadUsers(users: users)
            case .failure(let failure):
                print(failure)
                self.presenter?.didFail(error: failure.localizedDescription)
            }
        }
    }
}
