//
//  HomeViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

final class HomeViewModel {
    private var address : AddressModel
    
    init() {
        self.address = AddressModel.fixture()
    }
    
    func getAddressForCep(_ cep: String, completion: (() -> ())?) {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json/") else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: ", response.statusCode)
            }
            guard let data = data else { return }
            let address = try? JSONDecoder().decode(AddressModel.self, from: data)
            if let address = address {
                self.address = address
            }
            completion?()
        }.resume()
    }
    
    func retrieveAddress() -> AddressModel {
        return address
    }
}

