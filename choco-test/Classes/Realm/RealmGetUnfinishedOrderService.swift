//
//  RealmGetUnfinishedOrderService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation

class RealmGetUnfinishedOrderService: RealmGetService<RealmOrderObject> {
    
    init(forSupplierId supplierId: String) {
        super.init()
        result = result.filter("isFinished == false AND supplierId == %@", supplierId)
    }
}
