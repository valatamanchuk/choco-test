//
//  UIImageView+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension UIImageView {
    
    convenience init(withContentMode contentMode: UIView.ContentMode) {
        self.init()
        self.contentMode = contentMode
    }
}
