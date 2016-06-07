//
//  Goods+CoreDataProperties.swift
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

extension Goods {

    @NSManaged var content_desc_goods: String?
    @NSManaged var deposit: NSNumber?
    @NSManaged var id_goods: NSNumber?
    @NSManaged var name_goods: String?
    @NSManaged var pic_goods: String?
    @NSManaged var rent: NSNumber?
    @NSManaged var status_goods_isBorrowed: NSNumber?
    @NSManaged var status_goods_isDamaged: NSNumber?
    @NSManaged var status_goods_isOnShelf: NSNumber?
    @NSManaged var category: Category?
    @NSManaged var order: NSSet?
    @NSManaged var own: User?

}
