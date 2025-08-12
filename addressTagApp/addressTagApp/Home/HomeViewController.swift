//
//  HomeViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/08/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let homeViewModel = HomeViewModel()
    private var address: AddressModel?
    private var currentCep: String = ""
    
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
    
    
    @IBAction func textFieldCepEditingChanged(_ sender: UITextField) {
        self.currentCep = textFieldCep.text ?? ""
    }
    
    @IBAction func textFieldCepEditingDidEnd(_ sender: UITextField) {
        searchAddressForCep(currentCep) {
            self.fillTextFieldsFor(address: self.address)
        }
    }
    
    @IBAction func handlePrintAddress(_ sender: Any) {
    }
    
    @IBAction func handleSearchAddress(_ sender: Any) {
        searchAddressForCep(currentCep) {
            self.fillTextFieldsFor(address: self.address)
        }
    }
    
    private func searchAddressForCep(_ cep: String, completion: (() -> ())?) {
        homeViewModel.getAddressForCep(currentCep) { 
            self.reloadAddress()
            completion?()
        }
    }
    
    private func reloadAddress() {
        self.address = homeViewModel.retrieveAddress()
    }
    
    private func fillTextFieldsFor(address: AddressModel?) {
        guard let address = address else { return }
        DispatchQueue.main.async {
            self.textFieldState.text = address.estado
            self.textFieldRegion.text = address.regiao
            self.textFieldLocation.text = address.localidade
            self.textFieldLogradouro.text = address.logradouro
            self.textFieldNeighborhood.text = address.bairro
        }
    }
}
