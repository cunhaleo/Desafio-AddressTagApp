//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

final class TagViewModel {
    
    private let dataManager = DataManager.shared
    
    func generateFullAddressTextWith(newAddress: AddressModel?, savedItem: Address?) -> String {
        if let newAddress = newAddress {
            return
        """
        \(newAddress.logradouro ?? ""), \(newAddress.bairro ?? ""), \(newAddress.localidade ?? "") - \(newAddress.uf ?? "").
        CEP: \(newAddress.cep ?? "")
        ddd: \(newAddress.ddd ?? ""). Região: \(newAddress.regiao ?? "") (\(newAddress.estado ?? ""))
        """
        }
        return savedItem?.fullAddress ?? ""
    }
    
    func saveAddressInDevice(name: String, fullAddress: String) {
        dataManager.createItem(name: name, fullAddress: fullAddress)
    }
    
    func updateAddress(item: Address, newfullAddress: String) {
        dataManager.updateItem(item: item, newFullAddress: newfullAddress)
    }
}
