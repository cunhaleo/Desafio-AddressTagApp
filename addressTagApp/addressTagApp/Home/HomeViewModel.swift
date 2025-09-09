//
//  HomeViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/08/25.
//

import Foundation

final class HomeViewModel {
    private var address : AddressModel
    private let network: NetworkLayerProtocol
    
    init(network: NetworkLayerProtocol = NetworkLayer()) {
        self.address = AddressModel.fixture()
        self.network = network
    }
    
    func getAddressForCep(_ cep: String, completion: @escaping (() -> ())) {
        let endpoint = ServiceEndpoint.getAddressFor(cep: cep)
        guard let url = URL(string: endpoint) else { return }
        network.get(url: url) { [self] result in
            switch result {
            case .success(let data):
                if let address = try? network.decodeJson(data: data, objectType: AddressModel.self) {
                    self.address = address
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func retrieveAddress() -> AddressModel {
        return address
    }
}

