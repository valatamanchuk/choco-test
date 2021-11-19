//
//  ChocoNotifications.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

enum ChocoNotificationType: String {
    // Auth
    case userAuthorized = "userHasBeenAuthorized"
    case userUnauthorized = "userHasBeenUnauthorized"
    
    case userDidPlaceOrder = "userDidPlaceOrder"
}

private enum Constants {
    static let wrappingKey = "Choco.Notificaion.Data"
}

struct ChocoNotifications {
    static func register(notification: ChocoNotificationType, observer: Any, selector: Selector, object: Any? = nil) {
        let notificationName = Notification.Name(notification.rawValue)
        NotificationCenter.default.addObserver(observer, selector: selector, name: notificationName, object: object)
    }
    
    static func post(notification: ChocoNotificationType, withData data: Any? = nil, object: Any? = nil, userInfo: [AnyHashable: Any] = [:]) {
        var finalUserInfo = userInfo
        if let data = data {
            finalUserInfo[Constants.wrappingKey] = data
        }
        let notificationName = Notification.Name(notification.rawValue)
        NotificationCenter.default.post(name: notificationName, object: object, userInfo: finalUserInfo)
    }
}

extension Notification {
    func requiredValue<T>() -> T {
        guard let value = userInfo?[Constants.wrappingKey] as? T else { fatalError("Notification value not found!") }
        return value
    }
}
