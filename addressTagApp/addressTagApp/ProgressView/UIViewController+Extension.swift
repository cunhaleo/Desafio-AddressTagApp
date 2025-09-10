//
//  UIViewController+Extension.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import UIKit

protocol ProgressControlDelegate: AnyObject {
    func shouldShowProgress()
    func shouldDismissProgress()
}

extension UIViewController {
    func showProgress() {
        let progressView = ProgressView()
        progressView.frame = view.bounds
        self.view.addSubview(progressView)
    }
    
    func dismissProgress() {
        DispatchQueue.main.async {
            self.view.subviews.forEach({ view in
                if view is ProgressView {
                    view.removeFromSuperview()
                }
            })
        }
    }
}
