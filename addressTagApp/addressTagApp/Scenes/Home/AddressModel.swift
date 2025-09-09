//
//  AddressModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

struct AddressModel: Decodable {
    var cep: String?
    var logradouro: String?
    var complemento: String?
    var unidade: String?
    var bairro: String?
    var localidade: String?
    var uf: String?
    var estado: String?
    var regiao: String?
    var ibge: String?
    var gia: String?
    var ddd: String?
    var siafi: String?
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
