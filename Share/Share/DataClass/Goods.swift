//
//  Goods.swift
//  Share
//
//  Created by Eagle on 16/5/9.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Goods: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func totalNumOfGoods() -> Int{
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        var numOfGoods = 0
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchRequest) as! [Goods]
            for info: Goods in fetchedGoods as [Goods]{
                print(info.id_goods)
                numOfGoods += 1
            }
        } catch {
            fatalError("Faild to fetch Goods: \(error)")
        }
        
        return numOfGoods
    }
    
}
