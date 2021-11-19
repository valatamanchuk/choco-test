//
//  RealmFinishOrderService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmFinishOrderService: RealmSaveService<RealmOrderObject> {
    
    private let order: RealmOrderObject
    init(order: RealmOrderObject) {
        self.order = order
        super.init()
    }
    
    func setFinished() {
        try? realm.write {
            order.isFinished = true
        }
    }
}
