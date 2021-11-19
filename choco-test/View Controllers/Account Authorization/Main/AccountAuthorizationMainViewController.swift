//
//  AccountAuthorizationMainViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit
import SnapKit

private enum Constants {
    static let backgroundColor = UIColor.chocoColorDarkBlue
    
    static let titleLabelFont = UIFont.chocoFontBlack.withSize(49)
    static let titleLabelTextColor = UIColor(hex: "FFFFFF")
    static let titleLabelTopOffset: CGFloat = 37
    static let titleLabelLeftRightInset: CGFloat = 24
    
    static let subtitleLabelFont = UIFont.chocoFontRegular.withSize(17)
    static let subtitleLabelTextColor = UIColor(hex: "FFFFFF")
    static let subtitleLabelTopOffset: CGFloat = 16
    static let subtitleLabelLeftRightInset: CGFloat = 24
    
    static let cartImageViewSize = CGSize(width: 111, height: 104)
    static let cartImageViewCenterXToSuperviewCenterXAspectRatio: CGFloat = 0.96
    
    static let loginButtonTitleFont = UIFont.chocoFontSemibold.withSize(17)
    static let loginButtonTitleColor = UIColor(hex: "FFFFFF")
    static let loginButtonBackgroundColor = UIColor.chocoColorMainBlue
    static let loginButtonCornerRadius: CGFloat = 8
    static let loginButtonHeight: CGFloat = 52
    static let loginButtonLeftRightInset: CGFloat = 24
    static let loginButtonBottomInset: CGFloat = 24
}

class AccountAuthorizationMainViewController: ViewController {
    let titleLabel: UILabel = {
        let label = UILabel(font: Constants.titleLabelFont, textColor: Constants.titleLabelTextColor, text: "ORDERING, BUT BETTER")
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel(font: Constants.subtitleLabelFont, textColor: Constants.subtitleLabelTextColor, text: "Orders are converted into your supplier’s chosen format - email, WhatsApp, text, fax")
        label.numberOfLines = 0
        return label
    }()
    
    let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AccountAuthorizationCart")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Constants.loginButtonTitleFont
        button.backgroundColor = Constants.loginButtonBackgroundColor
        button.layer.cornerRadius = Constants.loginButtonCornerRadius
        button.setTitleColor(Constants.loginButtonTitleColor, for: .normal)
        button.setTitle("Log in", for: .normal)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.titleLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.titleLabelLeftRightInset)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subtitleLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.subtitleLabelLeftRightInset)
        }
        
        view.addSubview(cartImageView)
        cartImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(Constants.cartImageViewCenterXToSuperviewCenterXAspectRatio)
            make.size.equalTo(Constants.cartImageViewSize)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.loginButtonHeight)
            make.left.right.equalToSuperview().inset(Constants.loginButtonLeftRightInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.loginButtonBottomInset)
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc private func loginButtonClicked() {
        let vc = ViewControllersFactory.makeViewController(withType: .authorizationLogin)
        show(vc, sender: nil)
    }
}
