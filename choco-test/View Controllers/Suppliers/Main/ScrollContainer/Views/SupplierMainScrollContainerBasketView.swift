//
//  SupplierMainScrollContainerBasketView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let containerViewBackgroundColor = UIColor.chocoColorMainBlue
    static let containerViewCornerRadius: CGFloat = 13
    static let containerViewWidth: CGFloat = 110
    static let containerViewHeight: CGFloat = 56
    
    static let totalLabelFont = UIFont.chocoFontRegular.withSize(12)
    static let totalLabelTextColor = UIColor.white
    static let totalLabelTopOffset: CGFloat = 6
    static let totalLabelLeftRightInset: CGFloat = 4
    
    static let amountLabelFont = UIFont.chocoFontBold.withSize(16)
    static let amountLabelTextColor = UIColor.white
    static let amountLabelTopOffset: CGFloat = 5
    static let amountLabelLeftRightInset: CGFloat = 4
    
    static let shadowViewContainerCornerRadius: CGFloat = 13
    static let shadowViewContainerViewTopOffset: CGFloat = 12
    static let shadowViewContainerViewLeftRightInset: CGFloat = 10
    static let shadowViewContainerViewBottomInset: CGFloat = 3
    static let shadowViewContainerViewShadowProperties = CALayer.ShadowProperties(color: UIColor(hex: "0D162E"), alpha: 1, x: 0, y: 2, blur: 24, spread: 0)
}

class SupplierMainScrollContainerBasketView: UIView {
    
    let containerView: UIView = {
        let view = UIView(withBackgroundColor: Constants.containerViewBackgroundColor)
        view.layer.cornerRadius = Constants.containerViewCornerRadius
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel(font: Constants.totalLabelFont, textColor: Constants.totalLabelTextColor)
        label.textAlignment = .center
        label.text = "TOTAL"
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel(font: Constants.amountLabelFont, textColor: Constants.amountLabelTextColor)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let shadowViewContainerView: UIView = {
        let view = UIView(withBackgroundColor: .clear)
        view.layer.cornerRadius = Constants.shadowViewContainerCornerRadius
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(Constants.containerViewWidth)
            make.height.equalTo(Constants.containerViewHeight)
        }
        
        containerView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.totalLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.totalLabelLeftRightInset)
        }
        
        containerView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(Constants.amountLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.amountLabelLeftRightInset)
        }
        
        insertSubview(shadowViewContainerView, belowSubview: containerView)
        shadowViewContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.shadowViewContainerViewTopOffset)
            make.left.right.equalToSuperview().inset(Constants.shadowViewContainerViewLeftRightInset)
            make.bottom.equalToSuperview().inset(Constants.shadowViewContainerViewBottomInset)
        }
        
        shadowViewContainerView.layer.applySketchShadow(withShadowProperties: Constants.shadowViewContainerViewShadowProperties)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowViewContainerView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowViewContainerView.bounds, cornerRadius: shadowViewContainerView.layer.cornerRadius).cgPath
    }
    
    func configure(withViewModel viewModel: SupplierMainScrollContainerBasketViewViewModel) {
        amountLabel.text = viewModel.amount
    }
}
