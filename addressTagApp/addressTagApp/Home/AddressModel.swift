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
