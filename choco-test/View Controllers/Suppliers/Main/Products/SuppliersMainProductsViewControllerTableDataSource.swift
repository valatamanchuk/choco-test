//
//  SuppliersMainProductsViewControllerTableDataSource.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit

class SuppliersMainProductsViewControllerTableDataSource: NSObject, UITableViewDataSource {
    
    let tableView: UITableView
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var cellDelegate: SuppliersMainProductsViewControllerProductCellDelegate?
    init(withTableView tableView: UITableView) {
        self.tableView = tableView
        tableView.register(reusableCellWithClass: SuppliersMainProductsViewControllerProductCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusableCellWithClass: SuppliersMainProductsViewControllerProductCell.self, for: indexPath)
        
        let product = products[indexPath.row]
        let viewModel = SuppliersMainProductsViewControllerProductCellViewModel(withModel: product)
        cell.configure(withViewModel: viewModel)
        cell.delegate = cellDelegate
        
        return cell
    }
}
