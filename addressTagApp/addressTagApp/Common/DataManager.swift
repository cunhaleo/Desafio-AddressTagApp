//
//  File.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import Foundation

protocol DataManagerProtocol {
    func save(_ object: String)
    func read() -> String
}

final class DataManager: DataManagerProtocol {

    static let shared = DataManager()
    
    func save(_ object: String) {
        //code CORE DATA
    }
    
    func read() -> String {
        //code
        ""
    }
}
