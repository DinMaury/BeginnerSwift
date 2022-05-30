//
//  Stroe+CoreDataProperties.swift
//  DreamLister
//
//  Created by Maury on 20/05/22.
//
//

import Foundation
import CoreData


extension Stroe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stroe> {
        return NSFetchRequest<Stroe>(entityName: "Stroe")
    }

    @NSManaged public var name: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItem: NSSet?

}

// MARK: Generated accessors for toItem
extension Stroe {

    @objc(addToItemObject:)
    @NSManaged public func addToToItem(_ value: Item)

    @objc(removeToItemObject:)
    @NSManaged public func removeFromToItem(_ value: Item)

    @objc(addToItem:)
    @NSManaged public func addToToItem(_ values: NSSet)

    @objc(removeToItem:)
    @NSManaged public func removeFromToItem(_ values: NSSet)

}

extension Stroe : Identifiable {

}
