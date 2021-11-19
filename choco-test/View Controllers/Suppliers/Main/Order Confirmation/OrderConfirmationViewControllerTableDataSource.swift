//
//  OrderConfirmationViewControllerTableDataSource.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

class OrderConfirmationViewControllerTableDataSource: NSObject, UITableViewDataSource {
    
    let order: RealmOrderObject
    init(withTableView tableView: UITableView, order: RealmOrderObject) {
        self.order = order
        tableView.register(reusableCellWithClass: OrderProductCell.self)
        tableView.register(reusableCellWithClass: OrderTotalCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Adding one for the last 'total' cell
        return order.products.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == order.products.count {
            // Last row
            let cell = tableView.dequeue(reusableCellWithClass: OrderTotalCell.self, for: indexPath)
            let viewModel = OrderTotalCellViewModel(withModel: order)
            cell.configure(withViewModel: viewModel)
            return cell
        } else {
            let cell = tableView.dequeue(reusableCellWithClass: OrderProductCell.self, for: indexPath)
            let orderProduct = order.products[indexPath.row]
            let viewModel = OrderProductCellViewModel(withModel: orderProduct)
            cell.configure(withViewModel: viewModel)
            return cell
        }
    }
}
