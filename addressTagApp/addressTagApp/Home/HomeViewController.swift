//
//  HomeViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/08/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private var address: AddressModel
    private var currentCep: String = ""
    
    @IBOutlet weak var buttonSearchAddress: UIButton!
    @IBOutlet weak var buttonPrintTag: UIButton!
    
    @IBOutlet weak var textFieldCep: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldLogradouro: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldRegion: UITextField!
    @IBOutlet weak var textFieldNeighborhood: UITextField!
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    init(viewModel: HomeViewModel = HomeViewModel(), address: AddressModel = AddressModel.fixture()) {
        self.viewModel = viewModel
        self.address = address
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = ColorPallete.background
        buttonPrintTag.layer.cornerRadius = 15
        buttonPrintTag.backgroundColor = .darkGray
        buttonSearchAddress.layer.cornerRadius = 15
        buttonSearchAddress.backgroundColor = .darkGray
        imageViewLogo.image = ImageAsset.tagLogo
        
    }
    
    @IBAction func textFieldCepEditingChanged(_ sender: UITextField) {
        self.currentCep = textFieldCep.text ?? ""
    }
    
    @IBAction func textFieldCepEditingDidEnd(_ sender: UITextField) {
        searchAddressForCurrentCep {
            self.fillTextFieldsFor(address: self.address)
        }
    }
    
    @IBAction func handlePrintAddress(_ sender: Any) {
        updateAddressModel()
        goToTag()
    }
    
    private func updateAddressModel() {
        address.estado = textFieldState.text
        address.regiao = textFieldRegion.text
        address.localidade = textFieldLocation.text
        address.logradouro = textFieldLogradouro.text
        address.bairro = textFieldNeighborhood.text
    }
    
    @IBAction func handleSearchAddress(_ sender: Any) {
        searchAddressForCurrentCep() {
            self.fillTextFieldsFor(address: self.address)
        }
    }
    
    private func searchAddressForCurrentCep(completion: (() -> ())?) {
        viewModel.getAddressForCep(currentCep) {
            self.reloadAddress()
            completion?()
        }
    }
    
    private func reloadAddress() {
        self.address = viewModel.retrieveAddress()
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
    
    // MARK: Navigation
    
    private func goToTag() {
        let tagViewController = TagViewController(tagType: .newAddress, newAddress: address)
        navigationController?.pushViewController(tagViewController, animated: true)
    }
}
