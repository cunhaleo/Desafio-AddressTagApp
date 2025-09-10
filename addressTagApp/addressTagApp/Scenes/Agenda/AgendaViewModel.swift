//
//  AgendaViewModel.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import Foundation

final class AgendaViewModel {
    
    let dataManager = DataManager.shared
    
    func getAddressList() -> [Address] {
        let addressList = dataManager.getAllItems()
        return addressList
    }
    
    func deleteItem(item: Address, completion: @escaping ((Result<(), Error>) -> Void)) {
        dataManager.deleteItem(item: item, completion: completion)
    }
    
    func getAddressListContaining(_ searchText: String) -> [Address] {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        let secondPredicate = 
        let filteredAddressList = dataManager.getItems(predicate)
        return filteredAddressList
    }
}
