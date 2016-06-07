//
//  UI_confirmRequest.swift
//  Share
//
//  Created by Eagle on 16/5/29.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ConfirmRequest: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmShare(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let fetchOrderRequest: NSFetchRequest = NSFetchRequest(entityName: "Order")
        do{
            let fetchedOrder = try appContext.executeFetchRequest(fetchOrderRequest) as! [Order]
            for info:Order in fetchedOrder as [Order]{
                if(info.id_order == app.ID_selectedOrder){
                    info.status_order_isComfirmed = true
                    print("Order confirmed: \(info.id_order)")
                }
            }
            
            do {
                try appContext.save()
            } catch let error as NSError{
                print("confirm failed: \(error.localizedDescription)")
            }
            
        } catch {
            fatalError("Failed to fetch Order \(error)")
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}