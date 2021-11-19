//
//  RealmGetOrdersService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation

class RealmGetOrdersService: RealmGetService<RealmOrderObject> {
    
    override init() {
        super.init()
        result = result.filter("isFinished == true")
    }
}
