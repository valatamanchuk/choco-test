//
//  CALayer+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension CALayer {
    
    struct ShadowProperties {
        let color: UIColor?
        let alpha: Float?
        let x: CGFloat?
        let y: CGFloat?
        let blur: CGFloat?
        let spread: CGFloat?
    }
    
    func applySketchShadow(withShadowProperties shadowProperties: ShadowProperties) {
        applySketchShadow(color: shadowProperties.color, alpha: shadowProperties.alpha, x: shadowProperties.x, y: shadowProperties.y, blur: shadowProperties.blur, spread: shadowProperties.spread)
    }
    
    func applySketchShadow(color: UIColor?, alpha: Float?, x: CGFloat?, y: CGFloat?, blur: CGFloat?, spread: CGFloat?) {
        let shadowColorProperty = color?.cgColor ?? UIColor.black.cgColor
        let alphaProperty = alpha ?? 0.5
        let xProperty = x ?? 0
        let yProperty = y ?? 2
        let blurProperty = blur ?? 4
        let spreadProperty = spread ?? 0
        
        shadowColor = shadowColorProperty
        shadowOpacity = alphaProperty
        shadowOffset = CGSize(width: xProperty, height: yProperty)
        shadowRadius = blurProperty / 2.0
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spreadProperty
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
