//
//  ProgressViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import UIKit

final class ProgressView: UIView {
    
    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = false
        indicator.frame = .init(x: 20, y: 20, width: 20, height: 20)
        return indicator
    }()
    
    override func awakeFromNib() {
        buildLayout()
        backgroundColor = .black
        alpha = 0.2
        activityIndicator.startAnimating()
    }
    
    private func buildLayout() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
}
