//
//  HomeViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/08/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModeling
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
    
    init(viewModel: HomeViewModeling = HomeViewModel(),
         address: AddressModel = AddressModel.fixture()) {
        self.viewModel = viewModel
        self.address = address
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        title = "Novo endereço"
        view.backgroundColor = ColorPallete.background
        buttonPrintTag.layer.cornerRadius = 15
        buttonPrintTag.backgroundColor = ColorPallete.primaryButtonColor
        buttonSearchAddress.layer.cornerRadius = 15
        buttonSearchAddress.backgroundColor = ColorPallete.secondaryButtonColor
    }
    
    @IBAction func textFieldCepEditingChanged(_ sender: UITextField) {
        self.currentCep = textFieldCep.text ?? ""
    }
    
    @IBAction func textFieldCepEditingDidEnd(_ sender: UITextField) {
        searchAddressForCurrentCep { [weak self] in
            self?.fillTextFieldsFor(address: self?.address)
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
        searchAddressForCurrentCep() { [weak self] in
            self?.fillTextFieldsFor(address: self?.address)
        }
    }
    
    private func searchAddressForCurrentCep(completion: (() -> ())?) {
        viewModel.getAddressForCep(currentCep) { [weak self] in
            self?.reloadAddress()
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

extension HomeViewController: ProgressControlDelegate {
    func shouldShowProgress() {
        showProgress()
    }
    
    func shouldDismissProgress() {
        dismissProgress()
    }
}

