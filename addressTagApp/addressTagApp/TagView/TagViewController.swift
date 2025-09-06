//
//  TagViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 16/08/25.
//

import UIKit

final class TagViewController: UIViewController {
    
    // MARK: - Variables & Attributes
    
    private let address: AddressModel
    private let viewModel: TagViewModel
    
    // MARK: - Outlets

    @IBOutlet weak var labelFullAddress: UILabel!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func handleEdit(_ sender: Any) {
    }
    
    @IBAction func handleSave(_ sender: Any) {
    }
    
    //MARK: - Methods
    init(viewModel: TagViewModel = TagViewModel(), address: AddressModel) {
        self.address = address
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
