//
//  SearchTextFieldView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor(hex: "F8F8F8")
    static let cornerRadius: CGFloat = 6
    
    static let textFieldFont = UIFont.chocoFontRegular.withSize(17)
    static let textFieldTextColor = UIColor(hex: "8E8E94")
    static let textFieldLeftOffset: CGFloat = 10
    static let textFieldRightInset: CGFloat = 16
    
    static let searchImageViewLeftOffset: CGFloat = 10
    static let searchImageViewSize = CGSize(width: 14, height: 14)
    static let searchImageViewTopInset: CGFloat = 11
}

protocol SearchTextFieldViewDelegate: AnyObject {
    func searchTextFieldView(_ view: SearchTextFieldView, didUpdateSearchTextFieldWithText text: String)
}

class SearchTextFieldView: UIView {
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "search-icon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: "8E8E93")
        return imageView
    }()
    
    let textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding(frame: .zero, textPadding: .zero, placeholerPadding: .zero)
        textField.font = Constants.textFieldFont
        textField.textColor = Constants.textFieldTextColor
        textField.placeholder = "Search Products..."
        textField.autocorrectionType = .no
        return textField
    }()
    
    weak var delegate: SearchTextFieldViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(searchImageView)
        searchImageView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(Constants.searchImageViewLeftOffset)
            maker.size.equalTo(Constants.searchImageViewSize)
            maker.top.bottom.equalToSuperview().inset(Constants.searchImageViewTopInset)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { maker in
            maker.left.equalTo(searchImageView.snp.right).offset(Constants.textFieldLeftOffset)
            maker.right.equalToSuperview().inset(Constants.textFieldRightInset)
            maker.centerY.equalToSuperview()
        }
        
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldChanged(textField: UITextField) {
        let text = textField.text ?? ""
        delegate?.searchTextFieldView(self, didUpdateSearchTextFieldWithText: text)
    }
}
