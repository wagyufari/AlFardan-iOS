//
//  GetCurrencyUseCase.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation

struct GetCurrencyUseCase {
    
    let currencyRepository: CurrencyRepository
    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
    
    func invoke(completionHandler: @escaping (Result<[Currency], Error>) -> Void) {
        currencyRepository.fetchCurrencies(completion: completionHandler)
    }
    
}
