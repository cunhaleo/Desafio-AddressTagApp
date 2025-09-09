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
        guard let url = URL(string: ServiceEndpoint.getAddressFor(cep: cep)) else { return }
        network.get(url: url) { result in
            switch result {
            case .success(_):
                print("tratar sucesso")
            case .failure(_):
                print("tratar erro")
            }
        }
    }
    
    func retrieveAddress() -> AddressModel {
        return address
    }
}

