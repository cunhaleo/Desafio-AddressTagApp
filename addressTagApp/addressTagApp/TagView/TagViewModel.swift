//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

final class TagViewModel {
    
    private let db = DataManager.shared
    
    func generateFullAddressTextWith(address: AddressModel?, name: String?) -> String {
        if let address = address {
            return
        """
        \(address.logradouro ?? ""), \(address.bairro ?? ""), \(address.localidade ?? "") - \(address.uf ?? "").
        CEP: \(address.cep ?? "")
        ddd: \(address.ddd ?? ""). Região: \(address.regiao ?? "") (\(address.estado ?? ""))
        """
        }
        guard let name = name else { return "" }
        return readAddressInDevice(name: name)
    }
    
    func generateFullAddressTextWith(name: String) {
        
    }
    
    func readAddressInDevice(name: String) -> String {
        let address = db.getItem(name: name)
        return address.fullAddress ?? "
    }
    
    func saveAddressInDevice(name: String, fullAddress: String) {
        db.createItem(name: name, fullAddress: fullAddress)
    }
    
    func getAllAddresses() {
        
    }
    
}
