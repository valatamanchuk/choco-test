//
//  NSAttributedString+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 19.11.21.
//

import UIKit

extension NSAttributedString {
    
    static func textAttributes(forFont font: UIFont? = nil, color: UIColor? = nil, additionalAttributes: [NSAttributedString.Key: Any] = [:]) -> [NSAttributedString.Key: Any] {
        var textAttributes: [NSAttributedString.Key: Any] = [:]
        textAttributes[NSAttributedString.Key.font] = font
        textAttributes[NSAttributedString.Key.foregroundColor] = color
        
        additionalAttributes.forEach { textAttributes[$0.key] = $0.value }
        
        return textAttributes
    }
}
