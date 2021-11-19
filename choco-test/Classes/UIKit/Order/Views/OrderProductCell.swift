//
//  OrderConfirmationViewControllerProductCell.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let containerViewBackgroundColor = UIColor.white
    static let containerViewHeight: CGFloat = 57
    
    static let casesLabelFont = UIFont.chocoFontSemibold.withSize(13)
    static let casesLabelTextColor = UIColor(hex: "8E8E93")
    static let casesLabelTopOffset: CGFloat = 8
    static let casesLabelLeftOffset: CGFloat = 16
    
    static let titleLabelFont = UIFont.chocoFontSemibold.withSize(17)
    static let titleLabelTextColor = UIColor(hex: "333333")
    static let titleLabelTopOffset: CGFloat = 6
    static let titleLabelLeftOffset: CGFloat = 16
    
    static let priceLabelFont = UIFont.chocoFontSemibold.withSize(17)
    static let priceLabelTextColor = UIColor(hex: "333333")
    static let priceLabelRightInset: CGFloat = 16
    static let priceLabelLeftOffset: CGFloat = 10
    static let priceLabelBottomInset: CGFloat = 8
}

class OrderProductCell: UITableViewCell {
    
    let containerView = UIView(withBackgroundColor: Constants.containerViewBackgroundColor)
    let casesLabel = UILabel(font: Constants.casesLabelFont, textColor: Constants.casesLabelTextColor)
    let titleLabel = UILabel(font: Constants.titleLabelFont, textColor: Constants.titleLabelTextColor)
    let priceLabel = UILabel(font: Constants.priceLabelFont, textColor: Constants.priceLabelTextColor)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constants.containerViewHeight)
        }
        
        containerView.addSubview(casesLabel)
        casesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.casesLabelTopOffset)
            make.left.equalToSuperview().offset(Constants.casesLabelLeftOffset)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(casesLabel.snp.bottom).offset(Constants.titleLabelTopOffset)
            make.left.equalToSuperview().offset(Constants.titleLabelLeftOffset)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.priceLabelRightInset)
            make.left.equalTo(titleLabel.snp.right).offset(Constants.priceLabelLeftOffset)
            make.bottom.equalToSuperview().inset(Constants.priceLabelBottomInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: OrderProductCellViewModel) {
        casesLabel.text = viewModel.cases
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
    }
}
