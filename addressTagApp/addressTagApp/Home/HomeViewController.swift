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
    @IBOutlet weak var buttonPrintTag: UIButton!
    
    @IBOutlet weak var textFieldCep: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldLogradouro: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldRegion: UITextField!
    @IBOutlet weak var textFieldNeighborhood: UITextField!
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .gray
    }
    
    @IBAction func handlePrintAddress(_ sender: Any) {
    }
    
    @IBAction func handleSearchAddress(_ sender: Any) {
    }
    
    private func searchAddressForCep(_ cep: String, completion: ((AddressModel) -> ())?) {
        guard let currentCep = currentCep else { return }
        homeViewModel.getAddressForCep(currentCep) { address in
            if let address = address {
                completion?(address)
            }
        }
    }
    
    private func reloadAddress(_ address: AddressModel?) {
        
    }
}
