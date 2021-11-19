//
//  SuppliersMainScrollContainerHeaderCollectionDataSource.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

class SuppliersMainHeaderCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let collectionView: UICollectionView
    var selectedIndexPath: IndexPath?
    var suppliers: [Supplier] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(withCollectionView collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.register(reusableCellWithClass: SuppliersMainScrollContainerHeaderSupplierCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suppliers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(reusableCellWithClass: SuppliersMainScrollContainerHeaderSupplierCell.self, for: indexPath)
        cell.setSelected(selectedIndexPath == indexPath, animated: false)
        
        let supplier = suppliers[indexPath.row]
        let viewModel = SuppliersMainHeaderSupplierCellViewModel(withModel: supplier)
        cell.configure(withViewModel: viewModel)
        return cell
    }
}
