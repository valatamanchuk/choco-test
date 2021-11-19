//
//  OrderConfirmationViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let topLineViewBackgroundColor = UIColor(hex: "D8D8D8")
    static let topLineViewTopOffset: CGFloat = 6
    static let topLineViewHeight: CGFloat = 5
    static let topLineViewWidth: CGFloat = 37
    static let topLineViewCornerRadius: CGFloat = 2.5
    
    static let orderSummaryLabelFont = UIFont.chocoFontMedium.withSize(16)
    static let orderSummaryLabelTextColor = UIColor(hex: "333333")
    static let orderSummaryLabelTopOffset: CGFloat = 16
    
    static let orderButtonBackgroundColor = UIColor.chocoColorMainBlue
    static let orderButtonTitleFont = UIFont.chocoFontSemibold.withSize(17)
    static let orderButtonTitleColor = UIColor.white
    static let orderButtonCornerRadius: CGFloat = 8
    static let orderButtonHeight: CGFloat = 52
    static let orderButtonLeftRightInset: CGFloat = 24
    static let orderButtonBottomInset: CGFloat = 24
    
    static let tableViewTopOffset: CGFloat = 20
}

class OrderConfirmationViewController: ViewController {
    
    let topLineView: UIView = {
        let view = UIView(withBackgroundColor: Constants.topLineViewBackgroundColor)
        view.layer.cornerRadius = Constants.topLineViewCornerRadius
        return view
    }()
    
    let orderSummaryLabel = UILabel(font: Constants.orderSummaryLabelFont, textColor: Constants.orderSummaryLabelTextColor, text: "Order Summary")
    
    let tableView = UITableView(withSeparatorStyle: .none)
    lazy var tableDataSource = OrderConfirmationViewControllerTableDataSource(withTableView: tableView, order: order)
    
    let headerView = OrderConfirmationViewControllerHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 170))
    
    let orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.orderButtonBackgroundColor
        button.titleLabel?.font = Constants.orderButtonTitleFont
        button.setTitleColor(Constants.orderButtonTitleColor, for: .normal)
        button.layer.cornerRadius = Constants.orderButtonCornerRadius
        button.setTitle("Tap to order", for: .normal)
        return button
    }()
    
    let order: RealmOrderObject
    init(withOrder order: RealmOrderObject) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topLineViewTopOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.topLineViewHeight)
            make.width.equalTo(Constants.topLineViewWidth)
        }
        
        view.addSubview(orderSummaryLabel)
        orderSummaryLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(Constants.orderSummaryLabelTopOffset)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(orderSummaryLabel.snp.bottom).offset(Constants.tableViewTopOffset)
            make.left.bottom.right.equalToSuperview()
        }
        
        orderButton.addTarget(self, action: #selector(orderButtonClicked), for: .touchUpInside)
        
        tableView.tableHeaderView = headerView
        tableView.dataSource = tableDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90))
        orderButton.center.x = tableFooterView.center.x
        
        tableFooterView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.orderButtonHeight)
            make.left.right.equalToSuperview().inset(Constants.orderButtonLeftRightInset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.orderButtonBottomInset)
        }
        
        tableView.tableFooterView = tableFooterView
    }
    
    @objc func orderButtonClicked() {
        RealmFinishOrderService(order: order).setFinished()
        let vc = OrderConfirmedViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        dismiss(animated: true) {
            ChocoNotifications.post(notification: .userDidPlaceOrder)
        }
    }
}
