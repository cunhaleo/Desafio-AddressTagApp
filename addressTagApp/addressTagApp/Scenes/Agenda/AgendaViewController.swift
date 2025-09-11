//
//  AgendaViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import UIKit
import CoreData

final class AgendaViewController: UIViewController {
    
    private let viewModel: AgendaViewModeling
    private let tableView = UITableView()
    private let searchController = UISearchController()
    private var agendaResultControl: FetchResultsControling
    
    init(viewModel: AgendaViewModeling = AgendaViewModel(),
         fetchResultControl: FetchResultsControling = AgendaFetchResultsControl()) {
        self.viewModel = viewModel
        self.agendaResultControl = fetchResultControl
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
        agendaResultControl.loadSavedData(filterText: nil)
    }
}

extension AgendaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        agendaResultControl.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let itemName = agendaResultControl.item(at: indexPath)?.name
        cell.textLabel?.text = itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = agendaResultControl.item(at: indexPath)
        let tagView = TagViewController(tagType: .loadFromDatabase, savedItem: item)
        self.navigationController?.pushViewController(tagView, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let item = agendaResultControl.item(at: indexPath) else { return }
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
            agendaResultControl.loadSavedData(filterText: nil)
            return
        }
        agendaResultControl.loadSavedData(filterText: searchText)
        return
    }
}

extension AgendaViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        tableView.reloadData()
    }
}
