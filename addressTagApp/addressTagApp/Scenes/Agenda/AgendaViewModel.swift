//
//  AgendaViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import Foundation

protocol AgendaViewModeling {
    func getAddressList() -> [Address]
    func deleteItem(item: Address, completion: @escaping ((Result<(), Error>) -> Void))
    func getAddressListContaining(_ searchText: String) -> [Address]
}

final class AgendaViewModel: AgendaViewModeling {
    
    private let dataManager: DataManaging
    
    init(dataManager: DataManaging = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func getAddressList() -> [Address] {
        let addressList = dataManager.getAllItems()
        return addressList
    }
    
    func deleteItem(item: Address, completion: @escaping ((Result<(), Error>) -> Void)) {
        dataManager.deleteItem(item: item, completion: completion)
    }
    
    func getAddressListContaining(_ searchText: String) -> [Address] {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        let filteredAddressList = dataManager.getItems(predicate)
        return filteredAddressList
    }
}
