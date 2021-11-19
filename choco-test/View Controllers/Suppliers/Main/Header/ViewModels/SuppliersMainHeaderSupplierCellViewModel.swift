//
//  SuppliersMainScrollContainerHeaderSupplierCellViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

struct SuppliersMainHeaderSupplierCellViewModel {
    
    let logoURL: URL
    init(withModel model: Supplier) {
        logoURL = model.logoURL
    }
}
