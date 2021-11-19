//
//  ProfileViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor.white
    
    static let logOutButtonFont = UIFont.chocoFontSemibold.withSize(17)
    static let logOutButtonTitleColor = UIColor.chocoColorMainBlue
    static let logOutButtonBorderColor = UIColor.chocoColorMainBlue.cgColor
    static let logOutButtonBorderWidth: CGFloat = 1
    static let logOutButtonCornerRadius: CGFloat = 8
    static let logOutButtonHeight: CGFloat = 52
    static let logOutButtonLeftRightInset: CGFloat = 24
    static let logOutButtonBottomInset: CGFloat = 56
}

class ProfileViewController: ViewController {
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Constants.logOutButtonFont
        button.setTitleColor(UIColor.chocoColorMainBlue, for: .normal)
        button.setTitle("Log Out", for: .normal)
        button.layer.borderColor = Constants.logOutButtonBorderColor
        button.layer.borderWidth = Constants.logOutButtonBorderWidth
        button.layer.cornerRadius = Constants.logOutButtonCornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.logOutButtonHeight)
            make.left.right.equalToSuperview().inset(Constants.logOutButtonLeftRightInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.logOutButtonBottomInset)
        }
        
        logOutButton.addTarget(self, action: #selector(logOutButtonClicked), for: .touchUpInside)
    }
    
    @objc func logOutButtonClicked() {
        ChocoNotifications.post(notification: .userUnauthorized)
    }
}
