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
    
    // MARK: - Outlets
    @IBOutlet weak var textViewFullAddress: UITextView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    
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
        viewModel.saveAddressInDevice(address: textViewFullAddress.text)
    }
    
    //MARK: - Methods
    init(viewModel: TagViewModel = TagViewModel(), address: AddressModel? = nil) {
        self.address = address
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateFullAddressText() {
        self.textViewFullAddress.text = viewModel.generateFullAddressTextWith(address: address)
    }
    
    
    private func setupUI() {
        buttonEdit.layer.cornerRadius = 15
        buttonSave.layer.cornerRadius = 15
    }
}
