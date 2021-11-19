//
//  UIView+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

extension UIView {
    func pinEdges(toView anotherView: UIView) {
        snp.makeConstraints { $0.edges.equalTo(anotherView) }
    }
    
    func pinEdgesToSafeAreaLayoutGuide(ofAnotherView anotherView: UIView) {
        snp.makeConstraints { $0.edges.equalTo(anotherView.safeAreaLayoutGuide) }
    }
    
    func addSubviewAndPinEdges(subview: UIView) {
        addSubview(subview)
        subview.pinEdges(toView: self)
    }
}

extension UIView {
    convenience init(withBackgroundColor color: UIColor) {
        self.init()
        backgroundColor = color
    }
}

extension UIView {
    func animateBorderColor(toColor: UIColor, duration: Double) {
      let animation = CABasicAnimation(keyPath: "borderColor")
      animation.fromValue = layer.borderColor
      animation.toValue = toColor.cgColor
      animation.duration = duration
      layer.add(animation, forKey: "borderColor")
      layer.borderColor = toColor.cgColor
    }
    
    func animateShadowOpacity(shadowOpacity: Float, duration: Double) {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = shadowOpacity
        animation.duration = duration
        layer.add(animation, forKey: animation.keyPath)
        layer.shadowOpacity = shadowOpacity
    }
}
