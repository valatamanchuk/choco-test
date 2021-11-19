//
//  SuppliersMainScrollContainerHeaderSupplierCell.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit
import Kingfisher

private enum Constants {
    static let containerViewBorderColorSelected = UIColor.chocoColorMainBlue
    static let containerViewBorderColorUnselected = UIColor(hex: "D6D6D6")

    static let logoImageViewEdgesInset: CGFloat = 5
    
    static let selectedShadowViewContainerSize = CGSize(width: 44, height: 44)
    static let selectedShadowViewContainerBottomInset: CGFloat = 2
    static let selectedShadowViewContainerShadowProperties = CALayer.ShadowProperties(color: UIColor(hex: "0D162E"), alpha: 1, x: 0, y: 2, blur: 24, spread: 0)
}

class SuppliersMainScrollContainerHeaderSupplierCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView(withBackgroundColor: .white)
        view.clipsToBounds = true
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let selectedShadowViewContainer = UIView(withBackgroundColor: .clear)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewAndPinEdges(subview: containerView)
        
        containerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.logoImageViewEdgesInset)
        }
        
        insertSubview(selectedShadowViewContainer, belowSubview: containerView)
        selectedShadowViewContainer.snp.makeConstraints { make in
            make.size.equalTo(Constants.selectedShadowViewContainerSize)
            make.bottom.equalToSuperview().inset(Constants.selectedShadowViewContainerBottomInset)
            make.centerX.equalToSuperview()
        }
        
        selectedShadowViewContainer.layer.cornerRadius = 22
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(hex: "D6D6D6").cgColor
        
        selectedShadowViewContainer.layer.applySketchShadow(withShadowProperties: Constants.selectedShadowViewContainerShadowProperties)
        selectedShadowViewContainer.layer.shadowOpacity = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        selectedShadowViewContainer.layer.shadowPath = UIBezierPath(
            roundedRect: selectedShadowViewContainer.bounds, cornerRadius: selectedShadowViewContainer.layer.cornerRadius).cgPath
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        isSelected = selected
        
        let borderColor = isSelected ? Constants.containerViewBorderColorSelected : Constants.containerViewBorderColorUnselected
        let shadowOpacity: Float = selected ? 0.5 : 0
        
        containerView.layer.borderWidth = isSelected ? 2 : 1
        if animated {
            selectedShadowViewContainer.animateShadowOpacity(shadowOpacity: shadowOpacity, duration: 0.25)
            containerView.animateBorderColor(toColor: borderColor, duration: 0.25)
        } else {
            selectedShadowViewContainer.layer.shadowOpacity = shadowOpacity
            containerView.layer.borderColor = borderColor.cgColor
        }
    }
    
    func configure(withViewModel viewModel: SuppliersMainHeaderSupplierCellViewModel) {
        logoImageView.kf.setImage(with: viewModel.logoURL)
    }
}
