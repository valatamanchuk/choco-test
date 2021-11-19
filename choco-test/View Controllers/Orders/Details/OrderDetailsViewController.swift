//
//  OrderDetailsViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor.white
    
    static let iconImageViewContainerViewBorderWidth: CGFloat = 1
    static let iconImageViewContainerViewBorderColor = UIColor(hex: "D6D6D6").cgColor
    static let supplierIconImageViewContainerViewTopOffset: CGFloat = 18
    static let supplierIconImageViewContainerViewLeftOffset: CGFloat = 16
    static let supplierIconImageViewContainerViewSize = CGSize(width: 40, height: 40)
    
    static let orderIdLabelFont = UIFont.chocoFontMedium.withSize(16)
    static let orderIdLabelTextColor = UIColor.black
    static let orderIdLabelTopOffset: CGFloat = 21
    static let orderIdLabelLeftOffset: CGFloat = 12
    
    static let deliveryDateLabelFont = UIFont.chocoFontMedium.withSize(13)
    static let deliveryDateLabelTextColor = UIColor(hex: "8E8E93")
    static let deliveryDateLabelTopOffset: CGFloat = 2
    static let deliveryDateLabelLeftOffset: CGFloat = 12
    
    static let iconImageViewEdgesInset: CGFloat = 2
    static let iconImageViewContainerViewCornerRadius: CGFloat = 20
    
    static let separatorViewBackgroundColor = UIColor(hex: "D6D6D6")
    static let separatorViewTopOffset: CGFloat = 24
    static let separatorViewLeftRightInset: CGFloat = 16
    static let separatorViewHeight: CGFloat = 1
}

class OrderDetailsViewController: ViewController {
    
    // should reuse these views from OrderListOrderCell
    let supplierIconImageViewContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = Constants.iconImageViewContainerViewBorderWidth
        view.layer.borderColor = Constants.iconImageViewContainerViewBorderColor
        view.clipsToBounds = true
        return view
    }()
    
    let supplierIconImageView = UIImageView(withContentMode: .scaleAspectFit)
    
    let orderIdLabel = UILabel(font: Constants.orderIdLabelFont, textColor: Constants.orderIdLabelTextColor)
    let deliveryDateLabel = UILabel(font: Constants.deliveryDateLabelFont, textColor: Constants.deliveryDateLabelTextColor)
    let separatorView = UIView(withBackgroundColor: Constants.separatorViewBackgroundColor)
    
    let tableView = UITableView(withSeparatorStyle: .none)
    lazy var tableDataSource = OrderDetailsViewControllerTableDataSource(withTableView: tableView, order: order)
    let order: RealmOrderObject
    
    init(withOrder order: RealmOrderObject) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
        
        let viewModel = OrderDetailsViewControllerViewModel(withModel: order)
        configure(withViewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Order Details"
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(supplierIconImageViewContainerView)
        supplierIconImageViewContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.supplierIconImageViewContainerViewTopOffset)
            make.left.equalToSuperview().offset(Constants.supplierIconImageViewContainerViewLeftOffset)
            make.size.equalTo(Constants.supplierIconImageViewContainerViewSize)
        }
        
        supplierIconImageViewContainerView.addSubview(supplierIconImageView)
        supplierIconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.iconImageViewEdgesInset)
        }
        
        view.addSubview(orderIdLabel)
        orderIdLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.orderIdLabelTopOffset)
            make.left.equalTo(supplierIconImageViewContainerView.snp.right).offset(Constants.orderIdLabelLeftOffset)
        }
        
        view.addSubview(deliveryDateLabel)
        deliveryDateLabel.snp.makeConstraints { make in
            make.top.equalTo(orderIdLabel.snp.bottom).offset(Constants.deliveryDateLabelTopOffset)
            make.left.equalTo(supplierIconImageViewContainerView.snp.right).offset(Constants.deliveryDateLabelLeftOffset)
        }
        
        view.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(supplierIconImageViewContainerView.snp.bottom).offset(Constants.separatorViewTopOffset)
            make.left.right.equalToSuperview().inset(Constants.separatorViewLeftRightInset)
            make.height.equalTo(Constants.separatorViewHeight)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(24)
            make.left.bottom.right.equalToSuperview()
        }
        
        supplierIconImageViewContainerView.layer.cornerRadius = Constants.supplierIconImageViewContainerViewSize.height / 2
        tableView.dataSource = tableDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configure(withViewModel viewModel: OrderDetailsViewControllerViewModel) {
        orderIdLabel.text = viewModel.orderId
        deliveryDateLabel.text = viewModel.deliveryDate
        
        // Fake logo for saving time
        supplierIconImageView.image = UIImage(named: "sample-logo")
    }
}
