//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

final class TagViewModel {
    
    private let dataManager: DataManaging
    
    init(dataManager: DataManaging = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func generateFullAddressTextWith(newAddress: AddressModel?, savedItem: Address?) -> String {
        if let newAddress = newAddress {
            return
        """
        \(newAddress.street ?? ""), \(newAddress.neighborhood ?? ""), \(newAddress.city ?? "") - \(newAddress.stateCode ?? "").
        CEP: \(newAddress.zipCode ?? "")
        ddd: \(newAddress.areaCode ?? ""). Região: \(newAddress.region ?? "") (\(newAddress.state ?? ""))
        """
        }
        return savedItem?.fullAddress ?? ""
    }
    
    func saveAddressInDevice(name: String,
                             fullAddress: String,
                             completion: @escaping ((Result<(), Error>) -> Void)) {
        dataManager.createItem(name: name, fullAddress: fullAddress, completion: completion)
    }
    
    func updateAddress(item: Address, newfullAddress: String,
                       completion: @escaping ((Result<(), Error>) -> Void)) {
        dataManager.updateItem(item: item, newFullAddress: newfullAddress, completion: completion)
    }
}
