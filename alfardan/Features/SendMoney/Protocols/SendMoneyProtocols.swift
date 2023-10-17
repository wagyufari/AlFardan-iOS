//
//  SendMoneyProtocols.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI

protocol SendMoneyInteractorOutputProtocol: AnyObject {
    func didLoadCurrencies(currencies: [Currency])
    func didFail(error: String)
}

protocol SendMoneyInteractorInputProtocol: AnyObject {
    var presenter: SendMoneyInteractorOutputProtocol? { get set }
    
    func didFetchCurrencies()
}

protocol SendMoneyRouterProtocol: AnyObject {
    static func createModule(user: User) -> UIViewController
}
