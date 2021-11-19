//
//  UIViewController+Additions.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit
import SnapKit

public extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        return NavigationController(rootViewController: self)
    }
    
    func addChildViewControllerAndPinWithView(_ childViewController: UIViewController, toView view: UIView? = nil) {
        let view: UIView = view ?? self.view
        addChildViewControllerWithView(childViewController, toView: view) { maker in
            maker.edges.equalTo(view)
        }
    }
    
    func addChildViewControllerWithView(_ childViewController: UIViewController, toBack: Bool = false, toView view: UIView? = nil, _ constraintsMaker: ((_ make: ConstraintMaker) -> Void)? = nil) {
        let view: UIView = view ?? self.view
        
        childViewController.removeFromParentIfNeeded()
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        view.addSubview(childViewController.view)
        
        if let constraintsMaker = constraintsMaker {
            childViewController.view.snp.remakeConstraints(constraintsMaker)
            childViewController.view.setNeedsLayout()
            childViewController.view.layoutIfNeeded()
        }
    }
    
    func removeFromParentIfNeeded() {
        view.removeFromSuperview()
        if let parentViewController = parent {
            parentViewController.removeChildViewControllerWithView(self)
        }
    }
    
    func removeChildViewControllerWithView(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
