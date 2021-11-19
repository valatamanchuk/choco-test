//
//  SuppliersMainProductsViewControllerProductCell.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit

private enum Constants {
    static let containerViewBackgroundColor: UIColor = .white
    static let containerViewBottomInset: CGFloat = 8
    static let containerViewHeight: CGFloat = 87
    
    static let priceLabelFont = UIFont.chocoFontSemibold.withSize(13)
    static let priceLabelTextColor = UIColor(hex: "8E8E93")
    static let priceLabelLeftTopInset: CGFloat = 16
    
    static let titleLabelFont = UIFont.chocoFontSemibold.withSize(17)
    static let titleLabelTextColor = UIColor(hex: "333333")
    static let titleLabelTopOffset: CGFloat = 6
    static let titleLabelLeftOffset: CGFloat = 16
    
    static let amountInputViewTopOffset: CGFloat = 16
    static let amountInputRightInset: CGFloat = 12
    static let amountInputViewWidth: CGFloat = 131
    static let amountInputViewHeight: CGFloat = 47
}

protocol SuppliersMainProductsViewControllerProductCellDelegate: AnyObject {
    func suppliersMainProductsViewControllerProductCell(_ cell: SuppliersMainProductsViewControllerProductCell, didChangeValue value: Int, withProduct product: Product)
}

class SuppliersMainProductsViewControllerProductCell: UITableViewCell {
    
    let containerView = UIView(withBackgroundColor: Constants.containerViewBackgroundColor)
    
    let priceLabel = UILabel(font: Constants.priceLabelFont, textColor: Constants.priceLabelTextColor)
    let titleLabel = UILabel(font: Constants.titleLabelFont, textColor: Constants.titleLabelTextColor)
    let amountInputView = SuppliersMainProductsViewControllerProductCellAmountInputView(frame: .zero)
    var product: Product?
    
    weak var delegate: SuppliersMainProductsViewControllerProductCellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.containerViewBottomInset)
            make.height.equalTo(Constants.containerViewHeight)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(Constants.priceLabelLeftTopInset)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(Constants.titleLabelTopOffset)
            make.left.equalToSuperview().offset(Constants.titleLabelLeftOffset)
        }
        
        containerView.addSubview(amountInputView)
        amountInputView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.amountInputViewTopOffset)
            make.right.equalToSuperview().inset(Constants.amountInputRightInset)
            make.width.equalTo(Constants.amountInputViewWidth)
            make.height.equalTo(Constants.amountInputViewHeight)
        }
        
        amountInputView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SuppliersMainProductsViewControllerProductCellViewModel) {
        product = viewModel.product
        priceLabel.text = viewModel.price
        titleLabel.text = viewModel.title
    }
}

extension SuppliersMainProductsViewControllerProductCell: SuppliersMainProductsViewControllerProductCellAmountInputViewDelegate {
    
    func suppliersMainProductsViewControllerProductCellAmountInputView(_ view: SuppliersMainProductsViewControllerProductCellAmountInputView, didChangeValue value: Int) {
        guard let product = product else { return }
        delegate?.suppliersMainProductsViewControllerProductCell(self, didChangeValue: value, withProduct: product)
    }
}
