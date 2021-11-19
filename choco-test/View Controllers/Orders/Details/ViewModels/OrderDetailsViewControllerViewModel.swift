//
//  OrderDetailsViewControllerViewModel.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

struct OrderDetailsViewControllerViewModel {
    
    let orderId: String
    let deliveryDate: String
    init(withModel model: RealmOrderObject) {
        orderId = "Order #" + model.id.prefix(4)
        deliveryDate = "Delivery: 16 Nov 21"
    }
}
