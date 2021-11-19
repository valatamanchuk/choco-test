//
//  RealmService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmService {
    let realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Realm initialization failed \(error)")
        }
    }
}
