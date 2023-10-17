//
//  CurrencyRepository.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import Alamofire

class CurrencyRepository {
    
    private let apiCurrency = "https://mocki.io/v1/13759cf1-8cea-480f-b93b-2d7b0c486f81"
    
    func fetchCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        APIClient.shared.performRequest(apiCurrency, decodingType: [Currency].self, completion: completion)
    }
}
