//
//  SendMoneyViewController.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import PinLayout
import RxCocoa
import ReactiveSwift
import RxSwift
import SwiftUI
import URLImage

class SendMoneyViewController: UIViewController {
    
    var presenter: SendMoneyPresenter?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
}

struct SendMoneyView: View {
    
    @StateObject var presenter: SendMoneyPresenter
    
    @State private var frame = CGRect.zero
    
    
    
    @State private var showCurrencyPickerSheet = false
    
    var body: some View {
        VStack {
            Text("Send Money")
                .theme(.title1)
                .padding(.vertical, 16)
            
            VStack{
                Divider()
                HStack{
                    if let url = URL(string: presenter.user.profilePicture ?? "") {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            case .failure(let error):
                                Text("Error: \(error.localizedDescription)")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }

                    VStack(alignment: .leading){
                        Text("\(presenter.user.name ?? "")")
                            .theme(.body)
                            .foregroundStyle(Color.textPrimary)
                        Text("\(presenter.user.email ?? "")")
                            .theme(.caption)
                            .foregroundStyle(Color.textTertiary)
                    }
                    Spacer()
                }
                .padding(12)
                Divider()
            }
            
            HStack{
                Text("\(presenter.selectedCurrency.flag)")
                Text("\(presenter.selectedCurrency.code)")
                Image("ico-expand-more")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .frame(width: 24, height: 24)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .overlay{
                RoundedRectangle(cornerRadius: 64)
                    .stroke(Color.black.opacity(0.2), lineWidth: 0.7)
            }
            .padding(.top, 16)
            .onTapGesture {
                showCurrencyPickerSheet.toggle()
                presenter.interactor?.didFetchCurrencies()
            }
            
            HStack(alignment: .bottom, spacing: 8){
                Text(presenter.state == .SendingCurrency ? "AED" : presenter.selectedCurrency.code)
                    .foregroundStyle(Color.textPrimary)
                    .font(.system(size: 32))
                Text(presenter.nominal.isEmpty ? "0" : presenter.nominal)
                    .foregroundStyle(presenter.nominal.isEmpty ? Color.textTertiary : Color.textPrimary)
                    .font(.system(size: 64).bold())
                    .padding(.bottom, -16)
            }
            .padding(.top, 16)
            
            Text("Exchange rate of AED to \(presenter.selectedCurrency.code) is \(presenter.selectedCurrency.exchangeRateToAed)")
                .foregroundStyle(Color.textTertiary)
                .padding(.top, 16)
            
            Text("Enter from \(presenter.state == .SendingCurrency ? presenter.selectedCurrency.code : "AED")")
                .foregroundStyle(Color.primaryColor)
                .onTapGesture {
                    presenter.nominal = presenter.getConvertedString()
                    if presenter.state == .SendingCurrency {
                        presenter.state = .ReceivingCurrency
                    } else {
                        presenter.state = .SendingCurrency
                    }
                }
                .padding(.top, 16)
            
            VStack{
                HStack{
                    Text("1")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("1")
                        }
                    Text("2")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("2")
                        }
                    Text("3")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("3")
                        }
                }
                .frame(maxHeight: .infinity)
                HStack{
                    Text("4")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("4")
                        }
                    Text("5")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("5")
                        }
                    Text("6")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("6")
                        }
                }
                .frame(maxHeight: .infinity)
                HStack{
                    Text("7")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("7")
                        }
                    Text("8")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("8")
                        }
                    Text("9")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("9")
                        }
                }
                .frame(maxHeight: .infinity)
                HStack{
                    Text(".")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append(".")
                        }
                    Text("0")
                        .theme(.title2)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.nominal.append("0")
                        }
                    HStack{
                        Image("ico-backspace")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        if !presenter.nominal.isEmpty {
                            presenter.nominal.removeLast()
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
                let totalExchangeString = presenter.getConvertedString()
                let currencyCode = presenter.state == .SendingCurrency ? presenter.selectedCurrency.code : "AED"
                Text("Send \(totalExchangeString) \(currencyCode) to \(presenter.user.name ?? "")")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.primaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 24)
            }
            .frame(maxHeight: .infinity)
            .padding(.top, 64)
        }
        .sheet(isPresented: $showCurrencyPickerSheet, content: {
            if presenter.currencies.isEmpty {
                ProgressView()
            } else {
                ScrollView{
                    VStack{
                        ForEach(presenter.currencies, id: \.code) { currency in
                            VStack{
                                HStack{
                                    Text("\(currency.flag) \(currency.code)")
                                    Spacer()
                                }
                                .padding(16)
                                Divider()
                            }
                            .background(.white)
                            .onTapGesture {
                                presenter.selectedCurrency = currency
                                showCurrencyPickerSheet.toggle()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func rectReader(_ binding: Binding<CGRect>, _ space: CoordinateSpace = .global) -> some View {
        GeometryReader { (geometry) -> Color in
            let rect = geometry.frame(in: space)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return .clear
        }
    }
}
