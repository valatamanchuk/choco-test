//
//  OrderConfirmationViewControllerProductCellViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

struct OrderProductCellViewModel {
    
    let cases: String
    let title: String
    let price: String
    init(withModel model: RealmOrderProductObject) {
        cases = "cases: " + String(model.amount)
        title = model.title
        let totalPrice = model.price * model.amount
        price = String(format: "%.02f €", (Double(totalPrice) / 100))
    }
}
