//
//  NetworkLayer.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import Foundation

protocol NetworkLayerProtocol {
    func get(url: URL, completion: @escaping ((Result<Data, Error>) -> Void))
}

struct NetworkLayer: NetworkLayerProtocol {
    enum RequestType: String {
        case get = "GET"
        case post = "POST"
        case update = "UPDATE"
        case delete = "DELETE"
    }
    
    func get(url: URL, completion: @escaping ((Result<Data, Error>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.get.rawValue
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            }
            if let urlResponse = urlResponse as? HTTPURLResponse {
                print("STATUS CODE: \(urlResponse.statusCode.description)")
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
