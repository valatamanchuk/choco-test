//
//  RealmGetService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import Foundation
import RealmSwift

class RealmGetService<ResultObject: Object>: RealmService {
    typealias OnUpdate = (Results<ResultObject>) -> Void
    typealias ReturnObject = ResultObject
    typealias OnChanges = (RealmCollectionChange<Results<ResultObject>>) -> Void
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var result: Results<ResultObject>!
    var notificationToken: NotificationToken?
    var subscriptionToken: NotificationToken?
    var onUpdate: OnUpdate?
    private var onChanges: OnChanges?
    
    override init() {
        super.init()
        
        result = realm.objects(ResultObject.self)
        
        notificationToken = result.observe { [weak self] changes in
            guard let strongSelf = self else { return }
            strongSelf.onChanges?(changes)
            strongSelf.onUpdate?(strongSelf.result)
        }
    }
}
