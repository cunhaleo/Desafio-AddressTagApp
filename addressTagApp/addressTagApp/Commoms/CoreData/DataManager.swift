//
//  File.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//

import UIKit
import CoreData

protocol DataManaging {
    func getAllItems() -> [Address]
    func getItems(_ predicate: NSPredicate?) -> [Address]
    func createItem(name: String,
                    fullAddress: String,
                    completion: @escaping (Result<(), Error>) -> Void)
    func deleteItem(item: Address,
                    completion: @escaping (Result<(), Error>) -> Void)
    func updateItem(item: Address,
                    newFullAddress: String,
                    completion: @escaping (Result<(), Error>) -> Void)
}

final class DataManager: DataManaging {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let shared = DataManager()
    
    func getAllItems() -> [Address] {
        guard let items = try? context.fetch(Address.fetchRequest()) else { return [] }
        return items
    }
    
    func getItems(_ predicate: NSPredicate?) -> [Address] {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = predicate
        guard let items = try? context.fetch(request) else { return [] }
        return items
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
