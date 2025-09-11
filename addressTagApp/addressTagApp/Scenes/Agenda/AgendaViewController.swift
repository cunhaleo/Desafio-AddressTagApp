//
//  AgendaViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import UIKit
import CoreData

final class AgendaViewController: UIViewController {
    
    private let viewModel: AgendaViewModel
    private let tableView = UITableView()
    private let searchController = UISearchController()
    //    private var agendaResultControl = AgendaFetchResultsControl()
    var fetchedResultsController: NSFetchedResultsController<Address>?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(viewModel: AgendaViewModel = AgendaViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            fetchedResultsController?.delegate = self
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
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    override func viewDidLoad() {
        title = "Meus endereços"
        bindEvents()
        setupFetchResultControl()
        setupTableView()
        setupSearchController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        try? agendaResultControl.setupFetchedResultsController()
    }
    
    private func bindEvents() {
        //        agendaResultControl.shouldUpdate = { [weak self] in
        ////            self?.tableView.reloadData()
        //        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = ColorPallete.background
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Procurar"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupFetchResultControl() {
        loadSavedData()
    }
}

extension AgendaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        agendaResultControl.numberOfItems()
        fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let itemName = fetchedResultsController?.fetchedObjects?[indexPath.row].name
        cell.textLabel?.text = itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedResultsController?.fetchedObjects?[indexPath.row]
        let tagView = TagViewController(tagType: .loadFromDatabase, savedItem: item)
        self.navigationController?.pushViewController(tagView, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let item = fetchedResultsController?.fetchedObjects?[indexPath.row] else { return }
            viewModel.deleteItem(item: item) { [weak self] result in
                var alert = UIAlertController()
                switch result {
                case .success():
                    alert = DatabaseFeedback.alertDatabaseSuccess(type: .delete)
                case .failure(_):
                    alert = DatabaseFeedback.alertDatabaseFailed(type: .delete)
                }
                DispatchQueue.main.async {
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

extension AgendaViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            loadSavedData()
            return
        }
        loadSavedData(filterText: searchText)
        return
    }
}

extension AgendaViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
