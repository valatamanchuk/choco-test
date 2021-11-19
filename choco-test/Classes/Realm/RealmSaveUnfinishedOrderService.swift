//
//  RealmSaveUnfinishedOrderService.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import RealmSwift

class RealmSaveUnfinishedOrderService: RealmSaveService<RealmOrderObject> {
    
    func addProductToOrder(_ product: Product, amount: Int, supplierId: String) {
        if let existingUnfinishedOrder = RealmGetUnfinishedOrderService(forSupplierId: supplierId).result.first {
            try? realm.write {
                guard amount > 0 else {
                    // The amount of particular products are set to zero, so we need to remove previous products with this id if any exist
                    if let index = existingUnfinishedOrder.products.firstIndex(where: { $0.id == product.id }) {
                        existingUnfinishedOrder.products.remove(at: index)
                    }
                    return
                }
                
                if let orderProduct = existingUnfinishedOrder.products.first(where: { $0.id == product.id }) {
                    orderProduct.amount = amount
                } else {
                    let orderProduct = RealmOrderProductObject()
                    orderProduct.id = product.id
                    orderProduct.amount = amount
                    orderProduct.price = product.price
                    orderProduct.title = product.title
                    existingUnfinishedOrder.products.append(orderProduct)
                }
            }
        } else {
            // Create an order
            let unfinishedOrder = RealmOrderObject()
            unfinishedOrder.supplierId = supplierId
            
            let orderProduct = RealmOrderProductObject()
            orderProduct.id = product.id
            orderProduct.amount = amount
            orderProduct.price = product.price
            orderProduct.title = product.title
            
            unfinishedOrder.products.append(orderProduct)
            
            save(unfinishedOrder)
        }
    }
}
