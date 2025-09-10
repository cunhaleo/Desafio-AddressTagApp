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
    var fetchedResultsController: NSFetchedResultsController<Address>!
    
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    func setupFetchedResultsController(searchText: String? = nil,
                                       shouldReload: (() -> Void)? = nil) throws {
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        var predicates: [NSPredicate] = []
        if let searchText = searchText {
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
            shouldReload?()
        } catch {
            throw error
        }
    }
}
