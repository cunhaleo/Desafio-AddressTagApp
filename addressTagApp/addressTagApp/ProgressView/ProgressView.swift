//
//  ProgressViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import UIKit

final class ProgressView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
        }()

        private let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.layer.cornerRadius = 12
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupView() {
            addSubview(backgroundView)
            backgroundView.addSubview(activityIndicator)
            startLoading()

            NSLayoutConstraint.activate([
                backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
                backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
                backgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),

                activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
        }

        private func startLoading() {
            activityIndicator.startAnimating()
            isHidden = false
        }
}
