//
//  OrderListViewControllerOrderCell.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let containerViewCornerRadius: CGFloat = 16
    static let containerViewBorderColor = UIColor(hex: "D6D6D6").cgColor
    static let containerViewBorderWidth: CGFloat = 1
    static let containerViewLeftRightInset: CGFloat = 12
    static let containerViewBottomInset: CGFloat = 12
    static let containerViewHeight: CGFloat = 83
    
    static let iconImageViewContainerViewBorderWidth: CGFloat = 1
    static let iconImageViewContainerViewBorderColor = UIColor(hex: "D6D6D6").cgColor
    static let iconImageViewContainerViewTopOffset: CGFloat = 20
    static let iconImageViewContainerViewLeftOffset: CGFloat = 16
    static let iconImageViewContainerViewSize = CGSize(width: 40, height: 40)
    
    static let orderIdLabelFont = UIFont.chocoFontMedium.withSize(16)
    static let orderIdLabelTextColor = UIColor.black
    static let orderIdLabelTopOffset: CGFloat = 23
    static let orderIdLabelLeftOffset: CGFloat = 12
    
    static let deliveryDateLabelFont = UIFont.chocoFontMedium.withSize(13)
    static let deliveryDateLabelTextColor = UIColor(hex: "8E8E93")
    static let deliveryDateLabelTopOffset: CGFloat = 2
    static let deliveryDateLabelLeftOffset: CGFloat = 12
    
    static let priceLabelFont = UIFont.chocoFontBold.withSize(16)
    static let priceLabelTextColor = UIColor.black
    static let priceLabelTopOffset: CGFloat = 22
    static let priceLabelRightInset: CGFloat = 16
    static let priceLabelLeftOffset: CGFloat = 5
    
    static let iconImageViewEdgesInset: CGFloat = 2
    static let iconImageViewContainerViewCornerRadius: CGFloat = 20
}

class OrderListViewControllerOrderCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.containerViewCornerRadius
        view.layer.borderColor = Constants.containerViewBorderColor
        view.layer.borderWidth = Constants.containerViewBorderWidth
        return view
    }()
    
    let iconImageViewContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.iconImageViewContainerViewBorderWidth
        view.layer.borderColor = Constants.iconImageViewContainerViewBorderColor
        view.clipsToBounds = true
        return view
    }()
    
    let iconImageView = UIImageView(withContentMode: .scaleAspectFit)
    
    let orderIdLabel = UILabel(font: Constants.orderIdLabelFont, textColor: Constants.orderIdLabelTextColor)
    let deliveryDateLabel = UILabel(font: Constants.deliveryDateLabelFont, textColor: Constants.deliveryDateLabelTextColor)
    let priceLabel = UILabel(font: Constants.priceLabelFont, textColor: Constants.priceLabelTextColor)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(Constants.containerViewLeftRightInset)
            make.bottom.equalToSuperview().inset(Constants.containerViewBottomInset)
            make.height.equalTo(Constants.containerViewHeight)
        }
        
        containerView.addSubview(iconImageViewContainerView)
        iconImageViewContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.iconImageViewContainerViewTopOffset)
            make.left.equalToSuperview().offset(Constants.iconImageViewContainerViewLeftOffset)
            make.size.equalTo(Constants.iconImageViewContainerViewSize)
        }
        
        iconImageViewContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.iconImageViewEdgesInset)
        }
        
        containerView.addSubview(orderIdLabel)
        orderIdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.orderIdLabelTopOffset)
            make.left.equalTo(iconImageViewContainerView.snp.right).offset(Constants.orderIdLabelLeftOffset)
        }
        
        containerView.addSubview(deliveryDateLabel)
        deliveryDateLabel.snp.makeConstraints { make in
            make.top.equalTo(orderIdLabel.snp.bottom).offset(Constants.deliveryDateLabelTopOffset)
            make.left.equalTo(iconImageViewContainerView.snp.right).offset(Constants.deliveryDateLabelLeftOffset)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.priceLabelTopOffset)
            make.right.equalToSuperview().inset(Constants.priceLabelRightInset)
            make.left.equalTo(orderIdLabel.snp.right).offset(Constants.priceLabelLeftOffset)
        }
        
        iconImageViewContainerView.layer.cornerRadius = Constants.iconImageViewContainerViewCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: OrderListViewControllerOrderCellViewModel) {
        orderIdLabel.text = viewModel.orderId
        deliveryDateLabel.text = viewModel.deliveryDate
        priceLabel.text = viewModel.price
        
        // Fake logo for saving time
        iconImageView.image = UIImage(named: "sample-logo")
    }
}
