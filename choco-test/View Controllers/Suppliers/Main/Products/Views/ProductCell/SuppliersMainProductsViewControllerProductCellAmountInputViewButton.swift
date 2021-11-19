//
//  SuppliersMainProductsViewControllerProductCellAmountInputViewButton.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor.white
    static let cornerRadius: CGFloat = 6
    static let borderColor = UIColor(hex: "D6D6D6").cgColor
    static let borderWidth: CGFloat = 1
}

class SuppliersMainProductsViewControllerProductCellAmountInputViewButton: ButtonWithExpandedHitArea {
    
    var isExpanded = false
    
    init(frame: CGRect, isExpanded: Bool, image: UIImage?) {
        super.init(frame: .zero, withVerticalHitAreaMargin: 10, horizontalMargin: 10)
        self.isExpanded = isExpanded
        setImage(image, for: .normal)
        
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor
        layer.borderWidth = Constants.borderWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
