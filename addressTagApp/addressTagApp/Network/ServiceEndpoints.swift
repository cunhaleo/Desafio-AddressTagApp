//
//  ServiceEndpoints.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import Foundation

protocol ServiceEndpointProtocol {
    func getAddressFor(cep: String) -> String
}

struct ServiceEndpoint: ServiceEndpointProtocol {
    func getAddressFor(cep: String) -> String {
        "https://viacep.com.br/ws/\(cep)/json/"
    }
}
