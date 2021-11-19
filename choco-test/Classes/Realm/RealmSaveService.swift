//
//  RealmSaveService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmSaveService<ObjectClass: Object>: RealmService {
    
    func save(_ object: ObjectClass, withCompletionHandler completionHandler: (() -> Void)? = nil) {
        do {
            func addObject() {
                realm.add(object, update: .all)
                completionHandler?()
            }
            
            if self.realm.isInWriteTransaction {
                addObject()
            } else {
                try self.realm.write {
                    addObject()
                }
            }
        } catch let error {
            // Should let client know about the error
            completionHandler?()
            print("Save Service error:", error)
        }
    }
}
