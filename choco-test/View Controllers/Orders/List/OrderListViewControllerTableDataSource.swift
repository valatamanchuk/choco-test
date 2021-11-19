//
//  OrderListViewControllerTableDataSource.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit
import RealmSwift

class OrderListViewControllerTableDataSource: NSObject, UITableViewDataSource {
    
    let tableView: UITableView
    
    var notificationToken: NotificationToken?
    var ordersResult: Results<RealmOrderObject>?
    
    init(withTableView tableView: UITableView, withOrdersResult ordersResult: Results<RealmOrderObject>?) {
        self.tableView = tableView
        self.ordersResult = ordersResult
        tableView.register(reusableCellWithClass: OrderListViewControllerOrderCell.self)
        super.init()
        
        subscribeForOrdersUpdates()
    }
    
    func subscribeForOrdersUpdates() {
        notificationToken?.invalidate()
        
        notificationToken = ordersResult?.observe { [weak self] changes in
            guard let strongSelf = self else { return }
            switch changes {
            case .initial:
                strongSelf.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                strongSelf.tableView.beginUpdates()
                strongSelf.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                                with: .automatic)
                strongSelf.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                with: .automatic)
                strongSelf.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                with: .automatic)
                strongSelf.tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusableCellWithClass: OrderListViewControllerOrderCell.self, for: indexPath)
        
        if let order = ordersResult?[indexPath.row] {
            let viewModel = OrderListViewControllerOrderCellViewModel(withModel: order)
            cell.configure(withViewModel: viewModel)
        }
        
        return cell
    }
}
