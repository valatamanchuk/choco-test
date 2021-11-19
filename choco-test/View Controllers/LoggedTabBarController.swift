//
//  LoggedTabBarController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let tabBarTintColor = UIColor.chocoColorMainBlue
}

class LoggedTabBarController: UITabBarController {
    
    let suppliersViewController: UIViewController = {
        let vc = ViewControllersFactory.makeViewController(withType: .suppliersMainScrollContainer, embedInNavigationController: true)
        vc.tabBarItem = UITabBarItem(title: "Suppliers", image: UIImage(named: "tabbar-suppliers")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar-suppliers-active")?.withRenderingMode(.alwaysOriginal))
        return vc
    }()
    
    let globalViewController: UIViewController = {
        let vc = ViewControllersFactory.makeViewController(withType: .global, embedInNavigationController: true)
        vc.tabBarItem = UITabBarItem(title: "Global", image: UIImage(named: "tabbar-global")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar-global-active")?.withRenderingMode(.alwaysOriginal))
        return vc
    }()
    
    let ordersViewController: UIViewController = {
        let vc = ViewControllersFactory.makeViewController(withType: .orderListViewController, embedInNavigationController: true)
        vc.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "tabbar-orders")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar-orders-active")?.withRenderingMode(.alwaysOriginal))
        return vc
    }()
    
    let profileViewController: UIViewController = {
        let vc = ViewControllersFactory.makeViewController(withType: .profileViewController, embedInNavigationController: true)
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tabbar-profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar-profile-active")?.withRenderingMode(.alwaysOriginal))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = Constants.tabBarTintColor
        tabBar.backgroundColor = .white
        
        viewControllers = [suppliersViewController, globalViewController, ordersViewController, profileViewController]
    }
}
