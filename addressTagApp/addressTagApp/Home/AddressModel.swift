//
//  AddressModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

struct AddressModel: Decodable {
    let cep: String?
    let logradouro: String?
    let complemento: String?
    let unidade: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    let estado: String?
    let regiao: String?
    let ibge: String?
    let gia: String?
    let ddd: String?
    let siafi: String?
}

extension AddressModel {
    static func fixture(cep: String = "",
                        logradouro: String = "",
                        complemento: String = "",
                        unidade: String = "",
                        bairro: String = "",
                        localidade: String = "",
                        uf: String = "",
                        estado: String = "",
                        regiao: String = "",
                        ibge: String = "",
                        gia: String = "",
                        ddd: String = "",
                        siafi: String = "") -> Self {
        
        let address = AddressModel(cep: cep,
                     logradouro: logradouro,
                     complemento: complemento,
                     unidade: unidade,
                     bairro: bairro,
                     localidade: localidade,
                     uf: uf,
                     estado: estado,
                     regiao: regiao,
                     ibge: ibge,
                     gia: gia,
                     ddd: ddd,
                     siafi: siafi)
        return address
    }
}
