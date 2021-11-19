//
//  OrderListViewControllerTableEmptyDataView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let titleLabelFont = UIFont.chocoFontRegular.withSize(16)
    static let titleLabelTextColor = UIColor(hex: "333333")
    
    static let iconImageViewSize = CGSize(width: 71, height: 66)
    static let titleLabelTopOffset: CGFloat = 33
    
    static let widthToSuperviewWidthAspectRatio: CGFloat = 0.8
}

class OrderListViewControllerTableEmptyDataView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "AccountAuthorizationCart")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(font: Constants.titleLabelFont, textColor: Constants.titleLabelTextColor, text: "Hey, it’s about to time to make your first order")
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.iconImageViewSize)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(Constants.titleLabelTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthToSuperviewWidthAspectRatio)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
