//
//  AddressModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

struct AddressModel: Decodable {
    var zipCode: String?
    var street: String?
    var neighborhood: String?
    var city: String?
    var stateCode: String?
    var state: String?
    var region: String?
    var areaCode: String?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "cep"
        case street = "logradouro"
        case neighborhood = "bairro"
        case city = "localidade"
        case stateCode = "uf"
        case state = "estado"
        case region = "regiao"
        case areaCode = "ddd"
    }
}

extension AddressModel {
    static func fixture(zipCode: String = "",
                        street: String = "",
                        neighborhood: String = "",
                        city: String = "",
                        stateCode: String = "",
                        state: String = "",
                        region: String = "",
                        areaCode: String = "") -> Self {
        
        let address = AddressModel(zipCode: zipCode,
                                   street: street,
                                   neighborhood: neighborhood,
                                   city: city,
                                   stateCode: stateCode,
                                   state: state,
                                   region: region,
                                   areaCode: areaCode)
        
        return address
    }
}
