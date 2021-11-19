//
//  UITableView+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit

extension UITableView {
    
    convenience init(withSeparatorStyle separatorStyle: UITableViewCell.SeparatorStyle) {
        self.init()
        self.separatorStyle = separatorStyle
    }
    
    func register(reusableCellWithClass cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(reusableCellWithClass cellClass: T.Type, for indexPath: IndexPath, customization: ((T) -> Void)? = nil) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else { fatalError("Wasn't able to dequeue reusable cell") }
        customization?(cell)
        return cell
    }
}
