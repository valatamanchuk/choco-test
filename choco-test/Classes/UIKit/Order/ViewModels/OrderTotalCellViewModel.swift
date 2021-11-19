//
//  OrderConfirmationViewControllerTotalCellViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation

struct OrderTotalCellViewModel {
    
    let price: String
    init(withModel model: RealmOrderObject) {
        let totalPrice = model.products.compactMap { $0.price * $0.amount }.reduce(0, +)
        
        price = String(format: "%.02f €", (Double(totalPrice) / 100))
    }
}
