//
//  TextFieldWithPadding.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

class TextFieldWithPadding: UITextField {
    let textPadding: UIEdgeInsets
    var placeholderPadding: UIEdgeInsets
    init(frame: CGRect, textPadding: UIEdgeInsets, placeholerPadding: UIEdgeInsets) {
        self.textPadding = textPadding
        self.placeholderPadding = placeholerPadding
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
