//
//  UI_confirmGet.swift
//  Share
//
//  Created by Eagle on 16/5/29.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ConfirmGet: UIViewController {
    
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerPhone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        let fetchOrderRequest: NSFetchRequest = NSFetchRequest(entityName: "Order")
        do{
            let fetchedOrder = try appContext.executeFetchRequest(fetchOrderRequest) as! [Order]
            for info: Order in fetchedOrder as! [Order]{
                if(info.id_order == app.ID_selectedOrder){
                    goodName.text = info.beBorrowed?.name_goods!
                    startTime.text = String(info.date_startUse)
                    endTime.text = String(info.date_endUse)
                    ownerName.text = info.beBorrowed?.own?.name_user
                    ownerPhone.text = String(Int((info.beBorrowed?.own?.phoneNumber)!))
                }
            }
            
        } catch {
            fatalError("Failed to fetch Order: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmGet(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let fetchOrderRequest: NSFetchRequest = NSFetchRequest(entityName: "Order")
        do{
            let fetchedOrder = try appContext.executeFetchRequest(fetchOrderRequest) as! [Order]
            for info:Order in fetchedOrder as [Order]{
                if(info.id_order == app.ID_selectedOrder){
                    info.status_order_isGet = true
                    print("Get confirmed: \(info.id_order)")
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