//
//  SuppliersMainProductsViewControllerProductCellAmountInputView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit
import SnapKit

protocol SuppliersMainProductsViewControllerProductCellAmountInputViewDelegate: AnyObject {
    func suppliersMainProductsViewControllerProductCellAmountInputView(_ view: SuppliersMainProductsViewControllerProductCellAmountInputView, didChangeValue value: Int)
}

class SuppliersMainProductsViewControllerProductCellAmountInputView: UIView {
    
    let plusButton: SuppliersMainProductsViewControllerProductCellAmountInputViewButton = {
        let button = SuppliersMainProductsViewControllerProductCellAmountInputViewButton(frame: .zero, isExpanded: true, image: UIImage(named: "plus_icon_black"))
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let minusButton: SuppliersMainProductsViewControllerProductCellAmountInputViewButton = {
        let button = SuppliersMainProductsViewControllerProductCellAmountInputViewButton(frame: .zero, isExpanded: false, image: UIImage(named: "minus_icon_black"))
        return button
    }()
    
    let valueLabel = UILabel(font: UIFont.chocoFontSemibold.withSize(24), textColor: UIColor(hex: "30374B"))
    let caseLabel = UILabel(font: UIFont.chocoFontSemibold.withSize(13), textColor: UIColor(hex: "8E8E93"), text: "case")
    
    var minusButtonLeftConstraint: Constraint?
    
    var isMinusButtonExpanded = false
    var value: Int = 0
    weak var delegate: SuppliersMainProductsViewControllerProductCellAmountInputViewDelegate?
    
    init(frame: CGRect, currentValue: Int? = nil) {
        super.init(frame: frame)
        
        minusButton.alpha = 0
        
        isUserInteractionEnabled = true
        
        addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().priority(.medium)
            minusButtonLeftConstraint = make.left.equalToSuperview().priority(.low).constraint
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(valueLabel).offset(9)
            make.centerY.equalTo(minusButton)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
        
        addSubview(caseLabel)
        caseLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
        
        plusButton.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonClicked), for: .touchUpInside)
        
        if let currentValue = currentValue {
            minusButton.isExpanded = currentValue > 0
            expandMinusButton(expand: currentValue > 0)
            valueLabel.text = String(currentValue)
            value = currentValue
        } else {
            value = 0
            valueLabel.text = "0"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func minusButtonClicked() {
        guard value > 0 else { return }
        let newValue = value - 1
        setNewValue(value: newValue)
    }
    
    @objc func plusButtonClicked() {
        if !isMinusButtonExpanded {
            minusButton.isExpanded = true
            expandMinusButton(expand: true)
            setNewValue(value: 1)
        } else {
            let newValue = value + 1
            setNewValue(value: newValue)
        }
        
        valueLabel.text = String(value)
    }
    
    func setNewValue(value: Int, shouldCallDelegate: Bool = true) {
        valueLabel.text = String(value)
        self.value = value
        
        if value == 0 {
            expandMinusButton(expand: false)
        }
        
        if shouldCallDelegate {
            delegate?.suppliersMainProductsViewControllerProductCellAmountInputView(self, didChangeValue: value)
        }
    }
    
    private func expandMinusButton(expand: Bool) {
        isMinusButtonExpanded = expand
        minusButton.isExpanded = expand
        
        if expand {
            minusButtonLeftConstraint?.update(priority: .high)
        } else {
            minusButtonLeftConstraint?.update(priority: .low)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.minusButton.alpha = expand ? 1 : 0
            self.layoutIfNeeded()
        })
    }
}
