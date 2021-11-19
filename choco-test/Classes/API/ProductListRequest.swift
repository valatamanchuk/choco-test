//
//  ProductListRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import Foundation

struct Product {
    let id: String
    let title: String
    let price: Int
}

extension Product: Codable {}

class ProductListRequest: ChocoNetworkGetRequest, ObjectConstructibleNetworkResponse {
    typealias Object = [Product]
    
    let supplierId: String
    var urlPath: String {
        return "/api/v1/suppliers/" + supplierId + "/products"
    }
    
    init(withSupplierId supplierId: String) {
        self.supplierId = supplierId
    }
}
