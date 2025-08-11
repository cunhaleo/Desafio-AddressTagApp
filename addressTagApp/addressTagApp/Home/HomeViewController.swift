//
//  HomeViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/08/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    
    let homeViewModel = HomeViewModel(address: nil)
    private var currentCep: String? = "14021650"
    
    @IBOutlet weak var buttonSearchAddress: UIButton!

    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .gray
    }
    
    private func reloadAddress(_ address: AddressModel?) {
        
    }
    
    @IBAction func buttonSearchAdress(_ sender: Any) {
        guard let currentCep = currentCep else { return }
        homeViewModel.getAddressForCep(currentCep) { address in
            self.reloadAddress(address)
        }
    }
}
