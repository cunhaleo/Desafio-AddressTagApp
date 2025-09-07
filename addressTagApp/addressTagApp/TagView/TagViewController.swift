//
//  TagViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 16/08/25.
//

import UIKit

final class TagViewController: UIViewController {
    
    enum TagType {
        case newAddress
        case loadFromDatabase
    }
    
    // MARK: - Variables & Attributes
    
    private let newAddress: AddressModel?
    private let viewModel: TagViewModel
    private let savedItem: Address?
    private let tagType: TagType
    
    init(viewModel: TagViewModel = TagViewModel(),
         tagType: TagType,
         newAddress: AddressModel? = nil,
         savedItem: Address? = nil) {
        self.newAddress = newAddress
        self.viewModel = viewModel
        self.savedItem = savedItem
        self.tagType = tagType
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
        switch tagType {
        case .newAddress:
            showAlertRequiringName { [weak self] name in
                self?.viewModel.saveAddressInDevice(name: name, fullAddress: fullAddress) { [weak self] error in
                    let alert = DatabaseFeedback.alertDatabaseSuccess(type: .save)
                    DispatchQueue.main.async {
                        self?.present(alert, animated: true)
                    }
                }
            }
        case .loadFromDatabase:
            guard let savedItem = savedItem else { return }
            viewModel.updateAddress(item: savedItem, newfullAddress: fullAddress) { [weak self] error in
                let alert = DatabaseFeedback.alertDatabaseSuccess(type: .update)
                DispatchQueue.main.async {
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        buttonEdit.layer.cornerRadius = 15
        buttonSave.layer.cornerRadius = 15
        switch tagType {
        case .newAddress:
            labelTagTitle.text = "Novo endereço"
            buttonSave.setTitle("Salvar", for: .normal)
        case .loadFromDatabase:
            labelTagTitle.text = savedItem?.name ?? ""
            buttonSave.setTitle("Atualizar", for: .normal)
        }
    }
    
    private func generateFullAddressText() {
        self.textViewFullAddress.text = viewModel.generateFullAddressTextWith(newAddress: newAddress,
                                                                              savedItem: savedItem)
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
