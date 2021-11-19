//
//  NavigationController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let navigationBarTintColor = UIColor.white
    static let navigationBarTitleTextAttributes: [NSAttributedString.Key: Any] = NSAttributedString.textAttributes(forFont: UIFont.chocoFontMedium.withSize(16), color: UIColor(hex: "333333"))
}

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        if let navigationBarBackIcon = UIImage(named: "NavigationBarBackIcon") {
            navigationBar.backIndicatorImage = navigationBarBackIcon.withRenderingMode(.alwaysOriginal)
            navigationBar.backIndicatorTransitionMaskImage = navigationBarBackIcon.withRenderingMode(.alwaysOriginal)
        }
        
        configureNavigationBar(forPreferredStatusBarStyle: preferredStatusBarStyle)
    }
    
    private func configureNavigationBar(forPreferredStatusBarStyle style: UIStatusBarStyle) {
        navigationBar.tintColor = Constants.navigationBarTintColor
        navigationBar.titleTextAttributes = Constants.navigationBarTitleTextAttributes
    }
}

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        configureNavigationBar(forPreferredStatusBarStyle: viewController.preferredStatusBarStyle)
    }
}
