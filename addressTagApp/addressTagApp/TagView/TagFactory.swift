//
//  TagFactory.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import Foundation

enum TagFactory {
    enum TagType {
        case newTag
        case loadExistingTag
    }
    
    static func makeTagViewController(type: TagType,
                                      address: AddressModel? = nil,
                                      savedItem: Address? = nil) -> TagViewController {
        switch type {
        case .newTag:
            let tagViewController = TagViewController(address: address)
            return tagViewController
        case .loadExistingTag:
            let tagViewController = TagViewController(savedItem: savedItem)
            return tagViewController
        }
    }
}
