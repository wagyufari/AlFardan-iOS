//
//  HomeViewController.swift
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

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var presenter: HomePresenter?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        presenter?.viewDidLoad()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

class HomeView: UIView {
    
    var presenter: HomePresenter
    
    let titleLabel = UILabel()
    let signOutButton = UIImageView()
    let tableView = UITableView()
    
    let refreshControl = UIRefreshControl()
    let progressView = UIActivityIndicatorView()
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(signOutButton)
        addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        progressView.startAnimating()
        
        tableView.register(ItemUserCell.self, forCellReuseIdentifier: ItemUserCell.reuseIdentifier)
        
        presenter.users
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: ItemUserCell.reuseIdentifier, cellType: ItemUserCell.self)) { (row, user, cell) in
                self.progressView.isHidden = true
                cell.bindData(user: user)
                cell.contentView.onTap { _ in
                    presenter.didTapUser(user: user)
                }
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { _ in
                presenter.didFetchUsers()
            })
            .disposed(by: disposeBag)
        
        refreshControl.reactive.isRefreshing <~ presenter.isLoading
        
        presenter.didFetchUsers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setTheme(typography: .title1)
        titleLabel.text = "Send Money"
        titleLabel.textColor = .textPrimary
        
        signOutButton.image = UIImage(named: "ico-logout")?.withRenderingMode(.alwaysTemplate)
        signOutButton.tintColor = .textPrimary
        
        titleLabel.pin.sizeToFit().top(pin.safeArea.top).left(16)
        signOutButton.pin.height(32).width(32).vCenter(to: titleLabel.edge.vCenter).right(16)
        signOutButton.onTap { _ in
            self.presenter.didTapSignOut()
        }
        
        progressView.pin.below(of: signOutButton).marginTop(16).hCenter()
        
        tableView.pin.below(of: titleLabel).horizontally(16).bottom().marginTop(16)
        
        backgroundColor = .white
    }
    
}
