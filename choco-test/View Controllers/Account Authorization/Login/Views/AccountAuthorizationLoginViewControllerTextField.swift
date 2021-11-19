//
//  AccountAuthorizationLoginViewControllerTextField.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let textColor = UIColor(hex: "000000")
    static let font = UIFont.chocoFontMedium.withSize(16)
    static let cornerRadius: CGFloat = 8
    static let height: CGFloat = 48
    static let borderWidth: CGFloat = 1
    
    static let emptyStateBorderColor = UIColor(hex: "8E8E93").cgColor
    static let filledStateBorderColor = UIColor.chocoColorMainBlue.cgColor
}

class AccountAuthorizationLoginViewControllerTextField: TextFieldWithPadding {
    init(frame: CGRect = .zero) {
        super.init(frame: frame, textPadding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0), placeholerPadding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.emptyStateBorderColor
        font = Constants.font
        textColor = Constants.textColor
        snp.makeConstraints { $0.height.equalTo(Constants.height) }
        
        addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        layer.borderColor = text?.isEmpty == false ? Constants.filledStateBorderColor : Constants.emptyStateBorderColor
    }
}
