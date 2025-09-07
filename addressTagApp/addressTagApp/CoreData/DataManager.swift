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
    
    func getAllItems() -> [Address] {
        do {
            let items = try context.fetch(Address.fetchRequest())
            return items
        }
        catch {
            // error
        }
        return []
    }
    
    func getItem(name: String) -> Address {
        return Address()
    }
    
    func createItem(name: String, fullAddress: String) {
        let newItem = Address(context: context)
        newItem.name = name
        newItem.fullAddress = fullAddress
        save()
    }
    
    func deleteItem(item: Address) {
        context.delete(item)
        save()
    }
    
    func updateItem(item: Address, newFullAddress: String) {
        item.fullAddress = newFullAddress
        save()

    }
    
    private func save() {
        do {
            try context.save()
        }
        catch {
            // error
        }
    }
}
