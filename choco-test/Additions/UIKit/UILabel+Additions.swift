//
//  UILabel+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, text: String? = nil) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.text = text
    }
}
