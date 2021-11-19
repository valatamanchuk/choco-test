//
//  OrderListViewControllerOrderCellViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

struct OrderListViewControllerOrderCellViewModel {
    
    let orderId: String
    let deliveryDate: String
    let price: String
    init(withModel model: RealmOrderObject) {
        orderId = "Order #" + model.id.prefix(4)
        deliveryDate = "Delivery: 16 Nov 21"
        
        let totalPrice = model.products.compactMap { $0.price * $0.amount }.reduce(0, +)
        price = String(format: "%.02f €", (Double(totalPrice) / 100))
    }
}
