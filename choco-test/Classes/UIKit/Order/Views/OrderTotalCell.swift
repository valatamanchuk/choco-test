//
//  OrderConfirmationViewControllerTotalCell.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let containerViewBackgroundColor = UIColor(hex: "EEEEEE")
    static let containerViewCornerRadius: CGFloat = 12
    static let containerViewTopOffset: CGFloat = 24
    static let containerViewLeftRightInset: CGFloat = 16
    
    static let totalLabelFont = UIFont.chocoFontRegular.withSize(17)
    static let totalLabelTextColor = UIColor(hex: "8E8E93")
    static let totalLabelTopBottomInset: CGFloat = 14
    static let totalLabelLeftOffset: CGFloat = 16
    
    static let priceLabelFont = UIFont.chocoFontSemibold.withSize(17)
    static let priceLabelTextColor = UIColor(hex: "333333")
    static let priceLabelTopBottomInset: CGFloat = 14
    static let priceLabelRightInset: CGFloat = 14
    static let priceLabelLeftOffset: CGFloat = 14
}

class OrderTotalCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView(withBackgroundColor: UIColor(hex: "EEEEEE"))
        view.layer.cornerRadius = 12
        return view
    }()
    
    let totalLabel = UILabel(font: UIFont.chocoFontRegular.withSize(17), textColor: UIColor(hex: "8E8E93"), text: "Total: ")
    let priceLabel = UILabel(font: UIFont.chocoFontSemibold.withSize(17), textColor: UIColor(hex: "333333"))
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.containerViewTopOffset)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(Constants.containerViewLeftRightInset)
        }
        
        containerView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.totalLabelTopBottomInset)
            make.left.equalToSuperview().offset(Constants.totalLabelLeftOffset)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.priceLabelTopBottomInset)
            make.right.equalToSuperview().inset(Constants.priceLabelRightInset)
            make.left.equalTo(totalLabel.snp.right).offset(Constants.priceLabelLeftOffset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: OrderTotalCellViewModel) {
        priceLabel.text = viewModel.price
    }
}
