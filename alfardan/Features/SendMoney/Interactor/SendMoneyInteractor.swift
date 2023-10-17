//
//  SendMoneyInteractor.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

class SendMoneyInteractor: SendMoneyInteractorInputProtocol {
    
    var presenter: SendMoneyInteractorOutputProtocol?
    
    func didFetchCurrencies() {
        GetCurrencyUseCase(currencyRepository: CurrencyRepository()).invoke { result in
            switch result {
            case .success(let currencies):
                self.presenter?.didLoadCurrencies(currencies: currencies)
            case .failure(let failure):
                print(failure)
                self.presenter?.didFail(error: failure.localizedDescription)
            }
        }
    }
}
