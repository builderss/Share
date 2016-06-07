//
//  Order.swift
//  Share
//
//  Created by Eagle on 16/5/7.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Order: NSManagedObject {

    func NumOfOrder() -> Int{
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        var NumOfOrder = 0
        
        let fetchOrderRequest: NSFetchRequest = NSFetchRequest(entityName: "Order")
        do{
            let fetchedOrder = try appContext.executeFetchRequest(fetchOrderRequest) as! [Order]
            for _: Order in fetchedOrder as [Order] {
                NumOfOrder += 1
            }
        } catch {
            fatalError("Failed to fetch Order: \(error)")
        }
        return NumOfOrder
    }
// Insert code here to add functionality to your managed object subclass

}
