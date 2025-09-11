//
//  AgendaFetchResultsControl.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/09/25.
//

import CoreData
import UIKit

final class AgendaFetchResultsControl {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Address>?
    
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    func loadSavedData(filterText: String? = nil) {
        if fetchedResultsController == nil {
            let request = Address.fetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
            fetchedResultsController?.delegate = delegate
        }
        
        var predicates: [NSPredicate] = []
        if let filterText = filterText, !filterText.isEmpty {
            predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", filterText))
            predicates.append(NSPredicate(format: "fullAddress CONTAINS[cd] %@", filterText))
        }
        let addressPredicate = predicates.isEmpty ? nil : NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        fetchedResultsController?.fetchRequest.predicate = addressPredicate
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Fetch failed")
        }
    }
    
    func numberOfItems() -> Int {
        fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> Address? {
        guard let resultArray = fetchedResultsController?.fetchedObjects else { return nil}
        if resultArray.indices.contains(indexPath.row) {
            return fetchedResultsController?.object(at: indexPath)
        }
        return nil
    }
}



