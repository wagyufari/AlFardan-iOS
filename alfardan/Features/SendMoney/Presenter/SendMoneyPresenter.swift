//
//  SendMoneyPresenter.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import SwiftUI
import ReactiveSwift
import RxSwift
import RxCocoa

class SendMoneyPresenter: ObservableObject {
    
    var view: SendMoneyViewController?
    var interactor: SendMoneyInteractorInputProtocol?
    var router: SendMoneyRouterProtocol?
    
    @Published var currencies: [Currency] = []
    @Published var selectedCurrency = Currency(code: "USD", flag: "🇺🇸", exchangeRateToAed: 3.67)
    @Published var nominal = "100"
    
    @Published var state: SendMoneyState = .SendingCurrency
    
    let formatter: NumberFormatter = {
        let number = 123.456700
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getConvertedString() -> String {
        let nominal = (Double(nominal) ?? 0)
        let exchangeRate = selectedCurrency.exchangeRateToAed
        let totalExchange = state == .SendingCurrency ? nominal / exchangeRate : nominal * exchangeRate
        return formatter.string(from: NSNumber(value: totalExchange)) ?? ""
    }
    
    func viewDidLoad() {
        view?.useSwiftUI(rootView: {
            SendMoneyView(presenter: self)
        })
    }
}

enum SendMoneyState {
    case SendingCurrency
    case ReceivingCurrency
}

extension SendMoneyPresenter: SendMoneyInteractorOutputProtocol {
    func didFail(error: String) {
        SnackBar.show(message: error)
    }
    
    func didLoadCurrencies(currencies: [Currency]) {
        self.currencies = currencies
    }
   
}
