//
//  GlobalViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor.white
    
    static let messageLabelFont = UIFont.chocoFontRegular.withSize(16)
    static let messageLabelTextColor = UIColor(hex: "333333")
    
    static let iconImageViewCenterYToSuperviewCenterYAspectRatio: CGFloat = 0.9
    static let iconImageViewSize = CGSize(width: 66, height: 66)
    
    static let messageLabelTopOffset: CGFloat = 33
    static let messageLabelLeftRightInset: CGFloat = 24
}

class GlobalViewController: ViewController {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "bags-icon")
        return imageView
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel(font: Constants.messageLabelFont, textColor: Constants.messageLabelTextColor, text: "Global suppliers feature is coming soon. Stay tuned!")
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Global Suppliers"
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(Constants.iconImageViewCenterYToSuperviewCenterYAspectRatio)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.iconImageViewSize)
        }
        
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(Constants.messageLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.messageLabelLeftRightInset)
        }
    }
}
