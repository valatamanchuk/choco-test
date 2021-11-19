//
//  UICollectionView+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension UICollectionView {
    
    func register(reusableCellWithClass cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func register(reusableSupplementaryViewWithClass viewClass: UICollectionReusableView.Type, forSupplementaryViewOfKind kind: String) {
        register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewClass.classIdentifier)
    }
    
    func dequeue<T: UICollectionViewCell>(reusableCellWithClass cellClass: T.Type, for indexPath: IndexPath, customization: ((T) -> Void)? = nil) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else { fatalError("Wasn't able to dequeue resusable cell") }
        customization?(cell)
        return cell
    }
    
    func dequeue<T: UICollectionReusableView>(reusableSupplementaryViewOfKind kind: String, withClass: T.Type, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.classIdentifier, for: indexPath) as? T else { fatalError("Wasn't able to dequeue resusable supplementary view") }
        return view
    }
}
