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
    private let agendaResultControl: AgendaFetchResultsControl
    
    init(viewModel: AgendaViewModel = AgendaViewModel(),
         agendaResultControl: AgendaFetchResultsControl = AgendaFetchResultsControl()) {
        self.viewModel = viewModel
        self.agendaResultControl = agendaResultControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Meus endereços"
        setupFetchResultControl()
        setupTableView()
        setupSearchController()
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
        agendaResultControl.delegate = self
        do {
            try agendaResultControl.setupFetchedResultsController()
        } catch {
            let errorAlert = DatabaseFeedback.alertDatabaseFailed(type: .update)
            present(errorAlert, animated: true)
        }
    }
}

extension AgendaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        agendaResultControl.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let itemName = agendaResultControl.fetchedResultsController.fetchedObjects?[indexPath.row].name ?? ""
        cell.textLabel?.text = itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = agendaResultControl.fetchedResultsController.fetchedObjects?[indexPath.row]
        let tagView = TagViewController(tagType: .loadFromDatabase, savedItem: item)
        self.navigationController?.pushViewController(tagView, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let item = agendaResultControl.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
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
            do {
                try agendaResultControl.setupFetchedResultsController()
            }
            
            catch {
                let errorAlert = DatabaseFeedback.alertDatabaseFailed(type: .update)
                present(errorAlert, animated: true)
            }
            return
        }
        do {
            try agendaResultControl.setupFetchedResultsController(searchText: searchText)
        }
        catch {
            let errorAlert = DatabaseFeedback.alertDatabaseFailed(type: .update)
            present(errorAlert, animated: true)
        }
        tableView.reloadData()
        return
    }
}

extension AgendaViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        @unknown default:
            break
        }
    }
}
