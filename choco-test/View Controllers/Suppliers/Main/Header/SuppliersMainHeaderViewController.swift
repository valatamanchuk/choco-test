//
//  SuppliersMainScrollContainerHeaderViewController.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let backgroundColor = UIColor.white
    
    static let suppliersCollectionViewHeight: CGFloat = 72
    
    static let searchTextFieldViewTopOffset: CGFloat = 24
    static let searchTextFieldViewLeftOffset: CGFloat = 16
    
    static let chatButtonTopOffset: CGFloat = 31
    static let chatButtonRightInset: CGFloat = 20
    static let chatButtonLeftOffset: CGFloat = 21
    static let chatButtonBottomInset: CGFloat = 28
    static let chatButtonSize = CGSize(width: 22, height: 22)
}

protocol SuppliersMainHeaderViewControllerDelegate: AnyObject {
    func suppliersMainHeaderViewController(viewController: SuppliersMainHeaderViewController, didSelectSupplier supplier: Supplier)
}

class SuppliersMainHeaderViewController: ViewController {
    
    let suppliersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        flowLayout.itemSize = CGSize(width: 72, height: 72)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    let searchTextFieldView: SearchTextFieldView = {
        let searchTextFieldView = SearchTextFieldView()
        searchTextFieldView.isUserInteractionEnabled = false
        return searchTextFieldView
    }()
    
    let chatButton: ButtonWithExpandedHitArea = {
        let button = ButtonWithExpandedHitArea(frame: .zero, withVerticalHitAreaMargin: 7, horizontalMargin: 13)
        button.setImage(UIImage(named: "chat-icon"), for: .normal)
        return button
    }()
    
    lazy var collectionDataSource = SuppliersMainHeaderCollectionDataSource(withCollectionView: suppliersCollectionView)
    
    var selectedIndexPath: IndexPath? {
        didSet {
            collectionDataSource.selectedIndexPath = selectedIndexPath
        }
    }
    
    var suppliers: [Supplier] = [] {
        didSet {
            collectionDataSource.suppliers = suppliers
        }
    }
    
    weak var delegate: SuppliersMainHeaderViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(suppliersCollectionView)
        suppliersCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.suppliersCollectionViewHeight)
        }

        view.addSubview(searchTextFieldView)
        searchTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(suppliersCollectionView.snp.bottom).offset(Constants.searchTextFieldViewTopOffset)
            make.left.equalToSuperview().offset(Constants.searchTextFieldViewLeftOffset)
        }

        view.addSubview(chatButton)
        chatButton.snp.makeConstraints { make in
            make.top.equalTo(suppliersCollectionView.snp.bottom).offset(Constants.chatButtonTopOffset)
            make.right.equalToSuperview().inset(Constants.chatButtonRightInset)
            make.left.equalTo(searchTextFieldView.snp.right).offset(Constants.chatButtonLeftOffset)
            make.size.equalTo(Constants.chatButtonSize)
            make.bottom.equalToSuperview().inset(Constants.chatButtonBottomInset)
        }
        
        suppliersCollectionView.dataSource = collectionDataSource
        suppliersCollectionView.delegate = self
        
        SupplierListRequest().requestAndConstruct { [weak self] response in
            guard let strongSelf = self else { return }
            guard let suppliers = try? response.result.get() else { return }
            strongSelf.suppliers = suppliers
            
            // Select supplier on first load
            guard !suppliers.isEmpty else { return }
            strongSelf.suppliersCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
            strongSelf.suppliersCollectionView.delegate?.collectionView?(strongSelf.suppliersCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension SuppliersMainHeaderViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        
        (collectionView.cellForItem(at: indexPath) as? SuppliersMainScrollContainerHeaderSupplierCell)?.setSelected(true, animated: true)
        let supplier = suppliers[indexPath.item]
        delegate?.suppliersMainHeaderViewController(viewController: self, didSelectSupplier: supplier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? SuppliersMainScrollContainerHeaderSupplierCell)?.setSelected(false, animated: true)
    }
}
