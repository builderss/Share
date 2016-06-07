//
//  Order+CoreDataProperties.swift
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

extension Order {

    @NSManaged var address_get: String?
    @NSManaged var address_return: String?
    @NSManaged var content_desc_damage: String?
    @NSManaged var content_judge_borrower: String?
    @NSManaged var content_judge_goods: String?
    @NSManaged var content_judge_owner: String?
    @NSManaged var date_endUse: NSDate?
    @NSManaged var date_get: NSDate?
    @NSManaged var date_return: NSDate?
    @NSManaged var date_startUse: NSDate?
    @NSManaged var id_order: NSNumber?
    @NSManaged var status_order_isCompleted: NSNumber?
    @NSManaged var status_order_isGet: NSNumber?
    @NSManaged var status_order_isReturned: NSNumber?
    @NSManaged var status_order_isComfirmed: NSNumber?
    @NSManaged var beBorrowed: Goods?
    @NSManaged var borrow: User?

}
