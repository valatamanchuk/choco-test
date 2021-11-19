//
//  RealmOrderProductObject.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmOrderProductObject: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var amount: Int = 0
}
