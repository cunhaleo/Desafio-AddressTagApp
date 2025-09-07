//
//  AgendaViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import UIKit

final class AgendaViewController: UIViewController {
    
    let viewModel: AgendaViewModel
    var addressList = [Address]()
    
    init(viewModel: AgendaViewModel = AgendaViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAddressList()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = ColorPallete.agendaBackground
        view.addSubview(tableView)
    }
    
    private func loadAddressList() {
        self.addressList = viewModel.getAddressList()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension AgendaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let itemName = addressList[indexPath.row].name
        cell.textLabel?.text = itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = addressList[indexPath.row]
        let tagView = TagFactory.makeTagViewController(type: .loadExistingTag, savedItem: item)
        self.navigationController?.pushViewController(tagView, animated: true)
    }
}
