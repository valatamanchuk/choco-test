//
//  ActivityIndicatorView.swift
//  choco-test
//
//  Created by Val Atamanchuk on 17.11.21.
//

import UIKit

private enum Constants {
    static let indicatorContainerViewCornerRadius: CGFloat = 6
    static let indicatorContainerViewShadowColor: CGColor = UIColor.black.withAlphaComponent(0.12).cgColor
    static let indicatorContainerViewShadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let indicatorContainerViewShadowOpacity: Float = 1
    static let indicatorContainerViewShadowRadius: CGFloat = 13
    static let indicatorContainerViewBackgroundColor: UIColor = UIColor.white
    static let indicatorContainerViewSize: CGSize = CGSize(width: 130, height: 130)
    
    static let activityIndicatorViewColor = UIColor.chocoColorMainBlue
    
    static let backgroundViewBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.5)
    static let stopIndicatorAnimationDuration: TimeInterval = 0.3
}

class ActivityIndicatorView: UIView {
    
    static let shared: ActivityIndicatorView = ActivityIndicatorView()
    
    private let backgroundView = UIView(withBackgroundColor: Constants.backgroundViewBackgroundColor)
    private let indicatorContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.indicatorContainerViewCornerRadius
        view.layer.shadowColor = Constants.indicatorContainerViewShadowColor
        view.layer.shadowOffset = Constants.indicatorContainerViewShadowOffset
        view.layer.shadowOpacity = Constants.indicatorContainerViewShadowOpacity
        view.layer.shadowRadius = Constants.indicatorContainerViewShadowRadius
        view.backgroundColor = Constants.indicatorContainerViewBackgroundColor
        return view
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = Constants.activityIndicatorViewColor
        return view
    }()
    
    private var containerView: UIView? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundView)
        backgroundView.pinEdges(toView: self)
        
        addSubview(indicatorContainerView)
        indicatorContainerView.snp.makeConstraints { make in
            make.size.equalTo(Constants.indicatorContainerViewSize)
            make.center.equalToSuperview()
        }
        
        indicatorContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startIndicator() {
        guard let containerView = containerView else { return }
        containerView.addSubview(self)
        pinEdges(toView: containerView)
        activityIndicatorView.startAnimating()
    }
    
    func stopIndicator() {
        guard activityIndicatorView.isAnimating else { return }
        activityIndicatorView.stopAnimating()
        UIView.animate(withDuration: Constants.stopIndicatorAnimationDuration, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.alpha = 1
            guard !self.activityIndicatorView.isAnimating else { return }
            self.removeFromSuperview()
        })
    }
}
