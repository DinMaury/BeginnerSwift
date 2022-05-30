//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Maury on 20/05/22.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}

extension ItemType : Identifiable {

}
