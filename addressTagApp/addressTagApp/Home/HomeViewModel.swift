//
//  HomeViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

final class HomeViewModel {
    var address : AddressModel?
    
    init(address: AddressModel?) {
        self.address = address
    }
    func getAddressForCep(_ cep: String) {
        let url = URL(fileURLWithPath: "https://viacep.com.br/ws/\(cep)/json/")
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
        }.resume()
    }
}

