//
//  AgendaFetchResultsControl.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 10/09/25.
//

import CoreData
import UIKit

final class AgendaFetchResultsControl: NSObject, NSFetchedResultsControllerDelegate {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedResultsController: NSFetchedResultsController<Address>
    
    var shouldUpdate: (() -> Void)?
    
    override init() {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        try? setupFetchedResultsController()
        fetchedResultsController.delegate = self
    }
    
    func setupFetchedResultsController(searchText: String? = nil,
                                       shouldReload: (() -> Void)? = nil) throws {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var predicates: [NSPredicate] = []
        if let searchText = searchText, !searchText.isEmpty {
            predicates.append(NSPredicate(format: "name CONTAINS[cd] %@", searchText))
            predicates.append(NSPredicate(format: "fullAddress CONTAINS[cd] %@", searchText))
        }
        request.predicate = predicates.isEmpty ? nil : NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            throw error
        }
        shouldUpdate?()
    }
    
    func numberOfItems() -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> Address? {
        guard let resultArray = fetchedResultsController.fetchedObjects else { return nil}
        if resultArray.indices.contains(indexPath.row) {
            return fetchedResultsController.object(at: indexPath)
        }
        return nil
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        shouldUpdate?()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                        didChange anObject: Any,
                        at indexPath: IndexPath?,
                        for type: NSFetchedResultsChangeType,
                        newIndexPath: IndexPath?) {
    shouldUpdate?()
        }
}

   
