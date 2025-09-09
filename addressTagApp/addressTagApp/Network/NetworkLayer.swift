//
//  NetworkLayer.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 09/09/25.
//

import Foundation

protocol NetworkLayerProtocol {
    func get(url: URL, completion: @escaping ((Result<Data, Error>?) -> Void))
    func decodeJson<Model: Decodable>(data: Data, objectType: Model.Type) throws -> Model
}

struct NetworkLayer: NetworkLayerProtocol {
    
    func get(url: URL, completion: @escaping ((Result<Data, Error>?) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let urlResponse = urlResponse as? HTTPURLResponse {
                let statusCode = urlResponse.statusCode
                print("STATUS CODE: \(statusCode.description)")
                guard let data = data else { return }
                completion(.success(data))
            }
            completion(nil)
        }.resume()
    }
    
    func decodeJson<Model: Decodable>(data: Data, objectType: Model.Type) throws -> Model {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970
            let model = try decoder.decode(Model.self, from: data)
            return model
        }
        catch {
            throw error
        }
    }
}
