//
//  UICollectionViewCell+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return classIdentifier
    }
}
