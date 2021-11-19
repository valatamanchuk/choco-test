//
//  SuppliersMainProductsPagingContainerViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 18.11.21.
//

import UIKit
import Tabman
import Pageboy

class SuppliersMainProductsPagingContainerViewController: TabmanViewController {
    
    let bar = SuppliersMainProductsPagingContainerViewControllerBar()
    
    lazy var viewControllers: [UIViewController] = {
        [
            SuppliersMainProductsViewController(),
            SuppliersMainProductsViewController(),
            SuppliersMainProductsViewController(),
            SuppliersMainProductsViewController(),
            SuppliersMainProductsViewController(),
            SuppliersMainProductsViewController()
        ]
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        automaticallyAdjustsChildInsets = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isScrollEnabled = false
        dataSource = self
        delegate = self
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension SuppliersMainProductsPagingContainerViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title: String
        switch index {
        case 0: title = "Recently Ordered"
        case 1: title = "Seafood"
        case 2: title = "Meet"
        case 3: title = "Fruits"
        case 4: title = "Vegetables"
        case 5: title = "Alcohol"
        default: title = ""
        }
        
        return TMBarItem(title: title)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 0)
    }
}
