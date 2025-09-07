//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

final class TagViewModel {
    
    private let db = DataManager.shared
    
    func generateFullAddressTextWith(address: AddressModel?, savedItem: Address?) -> String {
        if let address = address {
            return
        """
        \(address.logradouro ?? ""), \(address.bairro ?? ""), \(address.localidade ?? "") - \(address.uf ?? "").
        CEP: \(address.cep ?? "")
        ddd: \(address.ddd ?? ""). Região: \(address.regiao ?? "") (\(address.estado ?? ""))
        """
        }
        return savedItem?.fullAddress ?? ""
    }
    
    func generateFullAddressTextWith(name: String) {
        
    }
    
    func saveAddressInDevice(name: String, fullAddress: String) {
        db.createItem(name: name, fullAddress: fullAddress)
    }
    
    func updateAddress(item: Address, newfullAddress: String) {
        db.updateItem(item: item, newFullAddress: newfullAddress)
    }
    
}
