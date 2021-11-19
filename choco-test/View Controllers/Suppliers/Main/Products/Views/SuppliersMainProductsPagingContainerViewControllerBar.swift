//
//  SuppliersMainProductsPagingContainerViewControllerBar.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit
import Tabman

private enum Constants {
    static let indicatorWeightValue: CGFloat = 4
    static let indicatorTintColor = UIColor.chocoColorMainBlue
    
    static let backgroundViewColor = UIColor.white
    
    static let interButtonSpacing: CGFloat = 40
    static let contentInsets = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 20)
    
    static let borderViewBackgroundColor = UIColor(hex: "333333")
    static let borderViewBottomInset: CGFloat = 1.8
    static let borderViewHeight: CGFloat = 1
    
    static let buttonsFont = UIFont.chocoFontRegular.withSize(15)
    static let buttonsSelectedFont = UIFont.chocoFontMedium.withSize(15)
    static let buttonsTintColor = UIColor(hex: "333333")
    static let buttonsSelectedColor = UIColor.chocoColorMainBlue
}

class SuppliersMainProductsPagingContainerViewControllerBar: TMBar.ButtonBar {
    
    let borderView = UIView(withBackgroundColor: Constants.borderViewBackgroundColor)
    required init() {
        super.init()
        
        indicator.weight = .custom(value: Constants.indicatorWeightValue)
        indicator.tintColor = Constants.indicatorTintColor
        backgroundView.style = .flat(color: Constants.backgroundViewColor)
        layout.contentMode = .intrinsic
        layout.interButtonSpacing = Constants.interButtonSpacing
        layout.contentInset = Constants.contentInsets
        
        buttons.customize { (button) in
            button.font = Constants.buttonsFont
            button.selectedFont = Constants.buttonsSelectedFont
            button.tintColor = Constants.buttonsTintColor
            button.selectedTintColor = Constants.buttonsSelectedColor
        }
        
        insertSubview(borderView, at: 1)
        borderView.snp.makeConstraints { make in
            make.height.equalTo(Constants.borderViewHeight)
            make.bottom.equalToSuperview().inset(Constants.borderViewBottomInset)
            make.left.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
