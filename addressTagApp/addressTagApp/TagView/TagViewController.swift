//
//  TagViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 16/08/25.
//

import UIKit

final class TagViewController: UIViewController {
    
    // MARK: - Variables & Attributes
    
    private let address: AddressModel?
    private let viewModel: TagViewModel
    private let savedItem: Address?
    
    init(viewModel: TagViewModel = TagViewModel(),
         address: AddressModel? = nil,
         savedItem: Address? = nil) {
        self.address = address
        self.viewModel = viewModel
        self.savedItem = savedItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var textViewFullAddress: UITextView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var labelTagTitle: UILabel!
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFullAddressText()
        setupUI()
    }
    
    //MARK: - Actions
    
    @IBAction func handleEdit(_ sender: Any) {
        textViewFullAddress.becomeFirstResponder()
    }
    
    @IBAction func handleSave(_ sender: Any) {
        let fullAddress = textViewFullAddress.text ?? ""
        showAlertRequiringName { [weak self] name in
            self?.viewModel.saveAddressInDevice(name: name, fullAddress: fullAddress)
        }
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        labelTagTitle.text = savedItem?.name ?? "Novo endereço"
        buttonEdit.layer.cornerRadius = 15
        buttonSave.layer.cornerRadius = 15
    }
    
    private func generateFullAddressText() {
        self.textViewFullAddress.text = viewModel.generateFullAddressTextWith(address: address, savedItem: savedItem)
    }
    
    private func showAlertRequiringName(completion: @escaping ((String) -> Void)) {
        let alert = UIAlertController(title: "Dê um nome a este endereço",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Nome"
        }
        
        let actionOK = UIAlertAction(title: "OK",
                                     style: .default) { _ in
            if let name = alert.textFields?.first?.text {
                completion(name)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancelar",
                                         style: .cancel,
                                         handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
