//
//  RealmOrderObject.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmOrderObject: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var supplierId: String = ""
    @objc dynamic var isFinished: Bool = false
    
    let products = List<RealmOrderProductObject>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
