//
//  HomeViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/08/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel(address: nil)
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .gray
    }
}
