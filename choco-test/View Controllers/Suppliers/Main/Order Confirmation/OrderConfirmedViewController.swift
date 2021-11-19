//
//  OrderConfirmedViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import UIKit

private enum Constants {
    static let backgroundColor = UIColor.chocoColorMainBlue
    
    static let doneLabelFont = UIFont.chocoFontBlack.withSize(49)
    static let doneLabelTextColor = UIColor.white
    static let doneLabelTopOffset: CGFloat = 48
    
    static let orderSentLabelFont = UIFont.chocoFontRegular.withSize(17)
    static let orderSentLabelTextColor = UIColor.white
    static let orderSentLabelTopOffset: CGFloat = 16
    static let orderSentLabelLeftRightInset: CGFloat = 24
    
    static let iconImageViewCenterYToSuperviewCenterYAspectRatio: CGFloat = 0.8
    static let iconImageViewSize = CGSize(width: 80, height: 80)
}

class OrderConfirmedViewController: UIViewController {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "checkmark-icon")
        return imageView
    }()
    
    let doneLabel = UILabel(font: Constants.doneLabelFont, textColor: Constants.doneLabelTextColor, text: "DONE!")
    let orderSentLabel: UILabel = {
        let label = UILabel(font: Constants.orderSentLabelFont, textColor: Constants.orderSentLabelTextColor, text: "Order has been successfuly sent!")
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.chocoColorMainBlue
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(Constants.iconImageViewCenterYToSuperviewCenterYAspectRatio)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.iconImageViewSize)
        }
        
        view.addSubview(doneLabel)
        doneLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(Constants.doneLabelTopOffset)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(orderSentLabel)
        orderSentLabel.snp.makeConstraints { make in
            make.top.equalTo(doneLabel.snp.bottom).offset(Constants.orderSentLabelTopOffset)
            make.left.right.equalToSuperview().inset(Constants.orderSentLabelLeftRightInset)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        perform(#selector(dismissController), with: nil, afterDelay: 2.3)
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
