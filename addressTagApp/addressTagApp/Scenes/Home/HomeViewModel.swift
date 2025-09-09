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
    private let serviceEndpoint: ServiceEndpointProtocol
    var delegate: ProgressControlDelegate?
    
    init(network: NetworkLayerProtocol = NetworkLayer(),
         serviceEndpoint: ServiceEndpointProtocol = ServiceEndpoint()) {
        self.address = AddressModel.fixture()
        self.network = network
        self.serviceEndpoint = serviceEndpoint
    }
    
    func getAddressForCep(_ cep: String, completion: @escaping (() -> ())) {
        let endpoint = serviceEndpoint.getAddressFor(cep: cep)
        guard let url = URL(string: endpoint) else { return }
        delegate?.shouldShowProgress()
        network.get(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                if let address = try? self?.network.decodeJson(data: data, objectType: AddressModel.self) {
                    self?.address = address
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.delegate?.shouldDismissProgress()
            completion()
        }
    }
    
    func retrieveAddress() -> AddressModel {
        return address
    }
}

