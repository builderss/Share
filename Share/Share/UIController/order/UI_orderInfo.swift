//
//  UI_orderInfo.swift
//  Share
//
//  Created by Eagle on 16/5/2.
//  Copyright © 2016年 myCompany. All rights reserved.
//
import UIKit
import CoreData

class OrderInfo: UIViewController {
    
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodAddress: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var goodOwner: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
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
                    let address:String = (info.beBorrowed?.own?.address_loc!)!
                    goodAddress.text = address + "围合"
                    startTime.text = String(info.date_startUse)
                    endTime.text = String(info.date_endUse)
                    goodOwner.text = info.beBorrowed?.own?.name_user
                    phoneNum.text = String(Int((info.beBorrowed?.own?.phoneNumber)!))
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
    
    @IBAction func returnButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}