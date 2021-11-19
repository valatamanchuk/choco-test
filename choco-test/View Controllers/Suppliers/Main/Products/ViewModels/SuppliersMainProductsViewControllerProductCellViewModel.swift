//
//  SuppliersMainProductsViewControllerProductCellViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit

struct SuppliersMainProductsViewControllerProductCellViewModel {
    
    let product: Product
    let price: String
    let title: String
    init(withModel model: Product) {
        product = model
        price = String(format: "Price: %.02f €", (Double(model.price) / 100))
        title = model.title
    }
}
