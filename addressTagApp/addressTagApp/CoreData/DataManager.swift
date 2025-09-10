//
//  File.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import UIKit
import CoreData

final class DataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let shared = DataManager()
    
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
    
    func getItems(_ predicate: NSPredicate? = nil) -> [Address] {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = predicate
        do {
            let items = try context.fetch(request)
            return items
        }
        catch {
            // error
        }
        return []
    }
    
    func createItem(name: String,
                    fullAddress: String,
                    completion: @escaping (Result<(), Error>) -> Void) {
        let newItem = Address(context: context)
        newItem.name = name
        newItem.fullAddress = fullAddress
        save(completion: completion)
    }
    
    func deleteItem(item: Address,
                    completion: @escaping (Result<(), Error>) -> Void) {
        context.delete(item)
        save(completion: completion)
    }
    
    func updateItem(item: Address,
                    newFullAddress: String,
                    completion: @escaping (Result<(), Error>) -> Void) {
        item.fullAddress = newFullAddress
        save(completion: completion)
    }
    
    private func save(completion: @escaping ((Result<(), Error>) -> Void)) {
        do {
            try context.save()
            completion(.success(()))
        }
        catch {
            completion(.failure(error))
        }
    }
}
