//
//  SuppliersMainScrollContainerViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit
import MXParallaxHeader
import RealmSwift

private enum Constants {
    static let basketViewRightInset: CGFloat = 12
    static let basketViewBottomInset: CGFloat = 70
}

class SuppliersMainScrollContainerViewController: MXScrollViewController {
    
    lazy var headerController = ViewControllersFactory.makeViewController(withType: .suppliersMainHeaderViewController(withDelegate: self))
    let suppliersMainProductsPagingContainerViewController = SuppliersMainProductsPagingContainerViewController()
    
    let basketView = SupplierMainScrollContainerBasketView(frame: .zero)
    var selectedSupplierId = "1"
    
    var notificationToken: NotificationToken?
    var unfinishedOrderResults = RealmGetUnfinishedOrderService(forSupplierId: "1").result
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        basketView.isHidden = true
        
        headerViewController = headerController
        childViewController = suppliersMainProductsPagingContainerViewController
        scrollView.panGestureRecognizer.cancelsTouchesInView = false
        
        view.addSubview(basketView)
        basketView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.basketViewRightInset)
            make.bottom.equalToSuperview().inset(Constants.basketViewBottomInset)
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(basketViewClicked))
        basketView.addGestureRecognizer(gestureRecognizer)
        
        subscribeForUnfinishedOrderUpdates(forSupplierId: "1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        scrollView.parallaxHeader.height = 151
        scrollView.parallaxHeader.minimumHeight = view.safeAreaInsets.top
        scrollView.parallaxHeader.delegate = self
    }
    
    func subscribeForUnfinishedOrderUpdates(forSupplierId supplierId: String) {
        notificationToken?.invalidate()
        
        notificationToken = unfinishedOrderResults?.observe { [weak self] _ in
            guard let strongSelf = self else { return }
            guard let order = strongSelf.unfinishedOrderResults?.first else {
                strongSelf.basketView.isHidden = true
                return
            }
            strongSelf.basketView.isHidden = order.products.isEmpty
            strongSelf.basketView.configure(withViewModel: SupplierMainScrollContainerBasketViewViewModel(withModel: order))
        }
    }
    
    @objc func basketViewClicked() {
        guard let order = unfinishedOrderResults?.first else { return }
        let vc = OrderConfirmationViewController(withOrder: order)
        present(vc, animated: true, completion: nil)
    }
}

extension SuppliersMainScrollContainerViewController: MXParallaxHeaderDelegate {
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        headerController.view.alpha = parallaxHeader.progress
    }
}

extension SuppliersMainScrollContainerViewController: SuppliersMainHeaderViewControllerDelegate {
    
    func suppliersMainHeaderViewController(viewController: SuppliersMainHeaderViewController, didSelectSupplier supplier: Supplier) {
        print("selected supplier", supplier)
    }
}
