//
//  AccountAuthorizationLoginViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor(hex: "FFFFFF")
    
    static let loginLabelFont = UIFont.chocoFontBlack.withSize(49)
    static let loginLabelTextColor = UIColor(hex: "000000")
    static let loginLabelTopOffset: CGFloat = 24
    static let loginLabelLeftRightInset: CGFloat = 23.5
    
    static let subtitleLabelFont = UIFont.chocoFontRegular.withSize(17)
    static let subtitleLabelTextColor = UIColor(hex: "000000")
    static let subtitleLabelTopOffset: CGFloat = 16
    static let subtitleLabelLeftRightInset: CGFloat = 24
    
    static let errorLabelFont = UIFont.chocoFontRegular.withSize(17)
    static let errorLabelTextColor = UIColor(hex: "FF0000")
    static let errorLabelTopOffset: CGFloat = 12
    static let errorLabelLeftRightInset: CGFloat = 24
    
    static let textFieldsStackViewSpacing: CGFloat = 12
    static let textFieldsStackViewTopOffset: CGFloat = 40
    static let textFieldsStackViewLeftRightInset: CGFloat = 24
    
    static let continueButtonHeight: CGFloat = 52
    static let continueButtonLeftRightInset: CGFloat = 24
    static let continueButtonBottomInset: CGFloat = 24
}

class AccountAuthorizationLoginViewController: ViewController {
    let loginLabel = UILabel(font: Constants.loginLabelFont, textColor: Constants.loginLabelTextColor, text: "LOG IN")
    let subtitleLabel: UILabel = {
        let label = UILabel(font: Constants.subtitleLabelFont, textColor: Constants.subtitleLabelTextColor, text: "Log in to your account in Choco for easy and quick ordering")
        label.numberOfLines = 2
        return label
    }()
    
    let emailTextField: AccountAuthorizationLoginViewControllerTextField = {
        let textField = AccountAuthorizationLoginViewControllerTextField()
        textField.placeholder = "your email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: AccountAuthorizationLoginViewControllerTextField = {
        let textField = AccountAuthorizationLoginViewControllerTextField()
        textField.placeholder = "your password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel(font: Constants.errorLabelFont, textColor: Constants.errorLabelTextColor, text: "Wrong login or password")
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let continueButton: AccountAuthorizationLoginViewControllerLoginButton = {
        let button = AccountAuthorizationLoginViewControllerLoginButton(frame: .zero)
        button.setTitle("Continue", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    lazy var textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField], axis: .vertical, spacing: Constants.textFieldsStackViewSpacing)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.loginLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.loginLabelLeftRightInset)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Constants.subtitleLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.subtitleLabelLeftRightInset)
        }
        
        view.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.textFieldsStackViewTopOffset)
            make.left.right.equalToSuperview().inset(Constants.textFieldsStackViewLeftRightInset)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Constants.errorLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.errorLabelLeftRightInset)
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.continueButtonHeight)
            make.left.right.equalToSuperview().inset(Constants.continueButtonLeftRightInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.continueButtonBottomInset)
        }
        
        continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textFieldsStackView.arrangedSubviews.forEach { ($0 as? UITextField)?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        errorLabel.isHidden = true
        continueButton.isEnabled = emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
    }
    
    @objc func continueButtonClicked() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        ActivityIndicatorView.shared.startIndicator()
        
        view.endEditing(true)
        AccountAuthorizationLoginRequest(email: email, password: password).requestAndConstruct { [weak self] response in
            ActivityIndicatorView.shared.stopIndicator()
            guard let strongSelf = self else { return }
            guard let token = try? response.result.get().token else {
                strongSelf.errorLabel.isHidden = false
                return
            }
            
            // MARK: - Having more time I would implement network middleware that would intercept the request looking for 'AccountAuthorizationLoginResponse' object then would post notifications from there. For now we gonna post it here.
            ChocoNotifications.post(notification: .userAuthorized, withData: token, object: nil, userInfo: [:])
        }
    }
    
    @objc internal func keyboardWillShow(_ notification: Notification?) {
        guard let keyboardSize = getKeyboardSizeForNotification(notification) else { return }
        updateContinueButtonBottomInset(withValue: keyboardSize.height)
    }
    
    @objc internal func keyboardWillHide(_ notification: Notification?) {
        guard let keyboardSize = getKeyboardSizeForNotification(notification) else { return }
        updateContinueButtonBottomInset(withValue: -keyboardSize.height)
    }
    
    private func getKeyboardSizeForNotification(_ notification: Notification?) -> CGSize? {
        guard let info = notification?.userInfo else { return nil }
        guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
        let intersectRect = keyboardFrame.intersection(UIScreen.main.bounds)
        let keyboardSize = intersectRect.isNull ? CGSize(width: UIScreen.main.bounds.size.width, height: 0) : intersectRect.size
        return keyboardSize
    }
    
    private func updateContinueButtonBottomInset(withValue value: CGFloat) {
        continueButton.snp.updateConstraints { $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(value) }
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
}
