//
//  TagViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

struct TagViewModel {
    
    func getFullAddress(for address: AddressModel) -> String {
        """
        \(address.logradouro ?? ""), \(address.bairro ?? ""), \(address.localidade ?? "") - \(address.uf ?? "").
        CEP: \(address.cep ?? "")
        ddd: \(address.ddd ?? ""). Região: \(address.regiao ?? "") (\(address.estado ?? ""))
        """
    }
}
