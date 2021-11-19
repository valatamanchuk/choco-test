//
//  ViewControllersFactory.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

struct ViewControllersFactory {
    
    enum ViewControllerType {
        // MARK: - Authorization
        case authorizationMain
        case authorizationLogin
        
        case loggedTabBarController
        
        // MARK: - Suppliers
        case suppliersMainScrollContainer
        case suppliersMainHeaderViewController(withDelegate: SuppliersMainHeaderViewControllerDelegate?)
        
        // MARK: - Orders
        case orderListViewController
        
        // MARK: - Profile
        case profileViewController
        
        // MARK: - Global
        case global
        
        var viewController: UIViewController {
            switch self {
            case .authorizationMain: return AccountAuthorizationMainViewController()
            case .authorizationLogin: return AccountAuthorizationLoginViewController()
            case .suppliersMainHeaderViewController(let delegate):
                let vc = SuppliersMainHeaderViewController()
                vc.delegate = delegate
                return vc
                
            case .loggedTabBarController: return LoggedTabBarController()
            case .suppliersMainScrollContainer:
                let vc = SuppliersMainScrollContainerViewController()
                return vc
                
            case .orderListViewController: return OrderListViewController()
                
            case .profileViewController: return ProfileViewController()
                
            case .global: return GlobalViewController()
            }
        }
    }
    
    static func makeViewController(withType type: ViewControllersFactory.ViewControllerType, embedInNavigationController: Bool = false) -> UIViewController {
        let typeViewController = type.viewController
        let viewController = embedInNavigationController ? typeViewController.embedInNavigationController() : typeViewController
        return viewController
    }
}
