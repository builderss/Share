//
//  User.swift
//  Share
//
//  Created by Eagle on 16/5/7.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func isRegisted(ID: Int) -> Bool {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        var isRegisted: Bool = false
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do{
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info_User: User in fetchedUser as [User]{
                //检测用户名
                if(ID == info_User.id_user){
                    isRegisted = true
                }
            }
        } catch{
            fatalError("Failed to fetch User: \(error)")
        }
        
        return isRegisted
    }
    
    func printUserInfo(){
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            print("------------------")
            for info:User in fetchedUser as[User]{
                print("id_user = \(info.id_user)")
                print("password = \(info.password)")
                /*
                 print("address_loc = \(info.address_loc)")
                 print("content_desc_user = \(info.content_desc_user)")
                 print("credit = \(info.credit)")
                 print("grade = \(info.grade)")
                 print("name_user = \(info.name_user)")
                 print("phoneNumber = \(info.phoneNumber)")
                 print("rank = \(info.rank)")
                 print("sex = \(info.sex)")
                 print("goods = \(info.goods)")
                 print("order = \(info.order)")
                 */
            }
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
    }
}
