//
//  SuppliersMainProductsViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit
import Tabman
import Pageboy
import SnapKit

private enum Constants {
    static let tableViewTopOffset: CGFloat = 44
}

class SuppliersMainProductsViewController: ViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var tableDataSource = SuppliersMainProductsViewControllerTableDataSource(withTableView: tableView)
    
    var products: [Product] = [] {
        didSet {
            tableDataSource.products = products
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableDataSource.cellDelegate = self
        tableView.dataSource = tableDataSource
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.tableViewTopOffset)
            make.left.right.bottom.equalToSuperview()
        }
        
        ProductListRequest(withSupplierId: "1").requestAndConstruct { [weak self] response in
            guard let strongSelf = self else { return }
            guard let products = try? response.result.get() else { return }
            strongSelf.products = products
        }
        
        ChocoNotifications.register(notification: .userDidPlaceOrder, observer: self, selector: #selector(userDidPlaceOrder))
    }
    
    @objc func userDidPlaceOrder(notification: Notification) {
        // bad timesaving solution
        tableView.visibleCells.forEach { ($0 as? SuppliersMainProductsViewControllerProductCell)?.amountInputView.setNewValue(value: 0, shouldCallDelegate: false) }
    }
}

extension SuppliersMainProductsViewController: SuppliersMainProductsViewControllerProductCellDelegate {
    
    func suppliersMainProductsViewControllerProductCell(_ cell: SuppliersMainProductsViewControllerProductCell, didChangeValue value: Int, withProduct product: Product) {
        RealmSaveUnfinishedOrderService().addProductToOrder(product, amount: value, supplierId: "1")
    }
}
