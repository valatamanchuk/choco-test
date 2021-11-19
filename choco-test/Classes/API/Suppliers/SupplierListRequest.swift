//
//  SupplierListRequest.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import Foundation

class SupplierListRequest: ChocoNetworkGetRequest, ObjectConstructibleNetworkResponse {
    typealias Object = [Supplier]
    
    var urlPath: String {
        return "/api/v1/suppliers"
    }
}
