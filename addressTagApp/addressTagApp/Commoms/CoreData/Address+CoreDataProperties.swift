//
//  Address+CoreDataProperties.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 06/09/25.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var name: String?
    @NSManaged public var fullAddress: String?

}

extension Address : Identifiable {

}
