//
//  ButtonWithExpandedHitArea.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let defaultHitAreaMargin: CGFloat = 20
}

class ButtonWithExpandedHitArea: UIButton {
    
    let verticalMargin: CGFloat
    let horizontalMargin: CGFloat
    init(frame: CGRect, withVerticalHitAreaMargin verticalMargin: CGFloat = Constants.defaultHitAreaMargin, horizontalMargin: CGFloat = Constants.defaultHitAreaMargin) {
        self.verticalMargin = verticalMargin
        self.horizontalMargin = horizontalMargin
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let area = bounds.insetBy(dx: -horizontalMargin, dy: -verticalMargin)
        return area.contains(point)
    }
}
