//
//  OrderConfirmationViewControllerHeaderView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let deliveryDateIconContainerViewCornerRadius: CGFloat = 10
    static let deliveryDateIconContainerViewBorderWidth: CGFloat = 1
    static let deliveryDateIconContainerViewBorderColor = UIColor(hex: "D6D6D6").cgColor
    
    static let deliveryDateLabelFont = UIFont.chocoFontMedium.withSize(15)
    static let deliveryDateLabelTextColor = UIColor(hex: "8E8E93")
    
    static let commentIconContainerViewCornerRadius: CGFloat = 10
    static let commentIconContainerViewBorderWidth: CGFloat = 1
    static let commentIconContainerViewBorderColor = UIColor(hex: "D6D6D6").cgColor
    
    static let commentTextViewFont = UIFont.chocoFontMedium.withSize(15)
    static let commentTextViewTextColor = UIColor(hex: "8E8E93")
    
    static let commentBorderViewBackgroundColor = UIColor(hex: "D6D6D6")
    
    static let deliveryDateContainerViewHeight: CGFloat = 52
    
    static let deliveryDateIconContainerViewLeftOffset: CGFloat = 16
    static let deliveryDateIconContainerViewTopBottomInset: CGFloat = 4
    static let deliveryDateIconContainerViewSize = CGSize(width: 46, height: 44)
    
    static let deliveryDateIconImageViewEdgesInset: CGFloat = 12
    
    static let deliveryDateLabelTopOffset: CGFloat = 15
    static let deliveryDateLabelLeftOffset: CGFloat = 12
    static let deliveryDateLabelRightInset: CGFloat = 16
    
    static let commentContainerViewTopOffset: CGFloat = 8
    static let commentContainerViewHeight: CGFloat = 88
    
    static let commentIconContainerViewTopOffset: CGFloat = 4
    static let commentIconContainerViewLeftOffset: CGFloat = 16
    static let commentIconContainerViewSize = CGSize(width: 46, height: 44)
    
    static let commentIconImageViewTopBottomInset: CGFloat = 12
    static let commentIconImageViewLeftRightInset: CGFloat = 14
    
    static let commentTextViewTopOffset: CGFloat = 5
    static let commentTextViewLeftOffset: CGFloat = 7
    static let commentTextViewRightInset: CGFloat = 12
    static let commentTextViewBottomInset: CGFloat = 12
    
    static let commentBorderViewHeight: CGFloat = 1
    static let commentBorderViewLeftRightInset: CGFloat = 16
}

class OrderConfirmationViewControllerHeaderView: UIView {
    
    let containerView = UIView()
    let deliveryDateContainerView = UIView()
    let deliveryDateIconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.deliveryDateIconContainerViewCornerRadius
        view.layer.borderWidth = Constants.deliveryDateIconContainerViewBorderWidth
        view.layer.borderColor = Constants.deliveryDateIconContainerViewBorderColor
        return view
    }()
    
    let deliveryDateIconImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "calendar-icon")
        return imageView
    }()
    
    let deliveryDateLabel = UILabel(font: Constants.deliveryDateLabelFont, textColor: Constants.deliveryDateLabelTextColor)
    
    let commentContainerView: UIView = {
        let view = UIView()
        return view
    }()
    let commentIconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.commentIconContainerViewCornerRadius
        view.layer.borderWidth = Constants.commentIconContainerViewBorderWidth
        view.layer.borderColor = Constants.commentIconContainerViewBorderColor
        return view
    }()
    
    let commentIconImageView: UIImageView = {
        let imageView = UIImageView(withContentMode: .scaleAspectFit)
        imageView.image = UIImage(named: "pencil-icon")
        return imageView
    }()
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = Constants.commentTextViewFont
        textView.textColor = Constants.commentTextViewTextColor
        textView.isEditable = false
        return textView
    }()
    
    let commentBorderView = UIView(withBackgroundColor: Constants.commentBorderViewBackgroundColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(deliveryDateContainerView)
        deliveryDateContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constants.deliveryDateContainerViewHeight)
        }
        
        deliveryDateContainerView.addSubview(deliveryDateIconContainerView)
        deliveryDateIconContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.left.equalToSuperview().offset(Constants.deliveryDateIconContainerViewLeftOffset)
            make.size.equalTo(Constants.deliveryDateIconContainerViewSize)
        }
        
        deliveryDateIconContainerView.addSubview(deliveryDateIconImageView)
        deliveryDateIconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.deliveryDateIconImageViewEdgesInset)
        }
        
        deliveryDateContainerView.addSubview(deliveryDateLabel)
        deliveryDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.deliveryDateLabelTopOffset)
            make.left.equalTo(deliveryDateIconContainerView.snp.right).offset(Constants.deliveryDateLabelLeftOffset)
            make.right.equalToSuperview().inset(Constants.deliveryDateLabelRightInset)
        }
        
        containerView.addSubview(commentContainerView)
        commentContainerView.snp.makeConstraints { make in
            make.top.equalTo(deliveryDateContainerView.snp.bottom).offset(Constants.commentContainerViewTopOffset)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.commentContainerViewHeight)
        }
        
        commentContainerView.addSubview(commentIconContainerView)
        commentIconContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.commentIconContainerViewTopOffset)
            make.left.equalToSuperview().offset(Constants.commentIconContainerViewLeftOffset)
            make.size.equalTo(Constants.commentIconContainerViewSize)
        }
        
        commentIconContainerView.addSubview(commentIconImageView)
        commentIconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.commentIconImageViewTopBottomInset)
            make.left.right.equalToSuperview().inset(Constants.commentIconImageViewLeftRightInset)
        }
        
        commentContainerView.addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.commentTextViewTopOffset)
            make.left.equalTo(commentIconContainerView.snp.right).offset(Constants.commentTextViewLeftOffset)
            make.right.equalToSuperview().inset(Constants.commentTextViewRightInset)
            make.bottom.equalToSuperview().inset(Constants.commentTextViewBottomInset)
        }
        
        commentContainerView.addSubview(commentBorderView)
        commentBorderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(Constants.commentBorderViewHeight)
            make.left.right.equalToSuperview().inset(Constants.commentBorderViewLeftRightInset)
        }
        
        deliveryDateLabel.text = "Request Delivery Date"
        commentTextView.text = "Comment to this order"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
