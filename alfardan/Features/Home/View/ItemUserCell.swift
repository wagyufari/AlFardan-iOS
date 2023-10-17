//
//  ItemUserCell.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import UIKit
import PinLayout

class ItemUserCell: UITableViewCell {
    
    static let reuseIdentifier = "ItemUserCell"
    
    let viewContainer = UIView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindData(user: User) {
        nameLabel.text = user.name ?? ""
        reloadView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        performLayout()
    }
    
    func performLayout() {
        nameLabel.textColor = .textPrimary
        
        viewContainer.pin.horizontally(16)
        nameLabel.pin.sizeToFit()
        viewContainer.pin.wrapContent(.vertically, padding: 12)
        viewContainer.layer.cornerRadius = 8
        
        contentView.pin.horizontally().wrapContent(.vertically)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize { contentView.pin.width(size.width)
        performLayout()
        return CGSize(width: contentView.frame.width, height: viewContainer.frame.maxY)
    }
}
