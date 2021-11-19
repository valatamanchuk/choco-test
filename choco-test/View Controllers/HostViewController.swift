//
//  HostViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let hostingTransitionAnimationDuration: TimeInterval = 0.3
}

class HostViewController: ViewController {
    
    let accountSession: AccountSession = AccountSession.shared
    fileprivate var hostedViewController: UIViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return hostedViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reconfigureHosting()
        ChocoNotifications.register(notification: .userAuthorized, observer: self, selector: #selector(userDidAuthenticate))
        ChocoNotifications.register(notification: .userUnauthorized, observer: self, selector: #selector(userDidUnauthenticate))
        ChocoNotifications.register(notification: .userDidPlaceOrder, observer: self, selector: #selector(userDidPlaceOrder))
    }
}

// MARK: - Notifications

extension HostViewController {
    
    @objc func userDidAuthenticate(notification: Notification) {
        guard let token: String = notification.requiredValue() else { return }
        let previousState = accountSession.currentState
        accountSession.authenticate(withToken: token)
        reconfigureHosting(fromPreviousState: previousState)
    }
    
    @objc func userDidUnauthenticate() {
        if case .loggedIn = accountSession.currentState {
            let previousState = accountSession.currentState
            accountSession.unauthenticate()

            print("Unauthenticated")
            reconfigureHosting(fromPreviousState: previousState)
        }
    }
    
    @objc func userDidPlaceOrder(notification: Notification) {
        let vc = OrderConfirmedViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        hostedViewController?.present(vc, animated: true, completion: nil)
    }
}

// MARK: - Hosting

extension HostViewController {
    
    func reconfigureHosting(fromPreviousState previousState: AccountSession.State? = nil) {
        if let navigationProvider = NavigationProviderFactory.navigationProvider(for: accountSession.currentState, from: previousState) {
            beginHosting(navigationProvider.viewController(for: accountSession.currentState))
        }
    }
    
    func beginHosting(_ viewController: UIViewController) {
        addChildViewControllerAndPinWithView(viewController)
        
        // Send controller behind currently hosted one if any
        view.sendSubviewToBack(viewController.view)
        
        // Remove currently hosted view controller
        if let hostedViewController = hostedViewController {
            UIView.animate(withDuration: Constants.hostingTransitionAnimationDuration, animations: {
                hostedViewController.view.alpha = 0
            }, completion: { _ in
                hostedViewController.dismiss(animated: false, completion: nil)
                hostedViewController.view.removeFromSuperview()
                hostedViewController.removeFromParent()
            })
        }
        
        // Update hosted view controller
        hostedViewController = viewController
        setNeedsStatusBarAppearanceUpdate()
    }
}
