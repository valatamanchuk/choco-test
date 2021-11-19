//
//  AccountAuthorizationLoginViewControllerLoginButton.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let titleFont = UIFont.chocoFontSemibold.withSize(17)
    static let titleColor = UIColor(hex: "FFFFFF")
    static let backgroundColor = UIColor.chocoColorMainBlue
    static let cornerRadius: CGFloat = 8
}

class AccountAuthorizationLoginViewControllerLoginButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = Constants.titleFont
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        setTitleColor(Constants.titleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
