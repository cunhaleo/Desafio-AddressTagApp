//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

final class TagViewModel {
    
    private var db: DataManagerProtocol
    
    init(db: DataManagerProtocol = DataManager.shared) {
        self.db = db
    }
    
    func getFullAddress(for address: AddressModel) -> String {
        """
        \(address.logradouro ?? ""), \(address.bairro ?? ""), \(address.localidade ?? "") - \(address.uf ?? "").
        CEP: \(address.cep ?? "")
        ddd: \(address.ddd ?? ""). Região: \(address.regiao ?? "") (\(address.estado ?? ""))
        """
    }
    
    func saveAddress(address: String) {
        db.save(address)
    }
    
}
