//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var address_loc: String?
    @NSManaged var content_desc_user: String?
    @NSManaged var credit: NSNumber?
    @NSManaged var grade: NSNumber?
    @NSManaged var id_user: NSNumber?
    @NSManaged var name_user: String?
    @NSManaged var password: String?
    @NSManaged var phoneNumber: NSNumber?
    @NSManaged var rank: NSNumber?
    @NSManaged var sex: String?
    @NSManaged var goods: NSSet?
    @NSManaged var order: NSSet?

}
