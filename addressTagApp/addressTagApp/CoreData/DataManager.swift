//
//  File.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import UIKit
import CoreData

protocol DataManagerProtocol {
    func save(_ object: String)
    func read() -> String
}

final class DataManager: DataManagerProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let shared = DataManager()
    
    func save(_ object: String) {
        //code CORE DATA
    }
    
    func read() -> String {
        //code
        ""
    }
}
