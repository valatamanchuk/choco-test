//
//  NSObject+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import Foundation

extension NSObject {
    
    static var classIdentifier: String {
        return String(describing: self)
    }
}
