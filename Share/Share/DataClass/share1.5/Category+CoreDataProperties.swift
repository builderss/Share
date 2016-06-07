//
//  Category+CoreDataProperties.swift
//  Share
//
//  Created by Eagle on 16/5/29.
//  Copyright © 2016年 myCompany. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var id_category: NSNumber?
    @NSManaged var kind: String?
    @NSManaged var belongTo: NSSet?

}
