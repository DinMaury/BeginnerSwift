//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Maury on 20/05/22.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = Date()
    }
}
