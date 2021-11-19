//
//  Supplier.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

struct Supplier {
    let id: String
    let name: String
    let logoURL: URL
}

extension Supplier: Codable {}
