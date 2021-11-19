//
//  OrderListViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

private enum Constants {
    static let backgroundColor = UIColor.white
    
    static let orderListLabelFont = UIFont.chocoFontMedium.withSize(16)
    static let orderListLabelTextColor = UIColor(hex: "333333")
    static let orderListTopOffset: CGFloat = 13

    static let tableViewTopOffset: CGFloat = 28
}

class OrderListViewController: ViewController {
    
    let orderListLabel = UILabel(font: Constants.orderListLabelFont, textColor: Constants.orderListLabelTextColor, text: "Order List")
    let tableView = UITableView(withSeparatorStyle: .none)
    lazy var tableDataSource = OrderListViewControllerTableDataSource(withTableView: tableView, withOrdersResult: ordersResult)
    var ordersResult = RealmGetOrdersService().result
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(orderListLabel)
        orderListLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.orderListTopOffset)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(orderListLabel.snp.bottom).offset(Constants.tableViewTopOffset)
            make.left.bottom.right.equalToSuperview()
        }
        
        tableView.dataSource = tableDataSource
        tableView.emptyDataSetSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension OrderListViewController: DZNEmptyDataSetSource {
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView {
        let view = OrderListViewControllerTableEmptyDataView(frame: .zero)
        return view
    }
}

extension OrderListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let order = ordersResult?[indexPath.row] else { return }
        let vc = OrderDetailsViewController(withOrder: order)
        show(vc, sender: nil)
    }
}
