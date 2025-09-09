//
//  ServiceEndpoints.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import Foundation

struct ServiceEndpoint {
    static func getAddressFor(cep: String) -> String {
        "https://viacep.com.br/ws/\(cep)/json/"
    }
}
