//
//  getGoods.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class GetGoods: UIViewController {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    var startDate: NSDate!
    var endDate: NSDate!
    var isAccepet: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var rent: UILabel!
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerEnd: UIDatePicker!
    @IBOutlet weak var warnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(300, 1000)
        // Do any additional setup after loading the view, typically from a nib.
        let appContext = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchRequest) as! [Goods]
            for info: Goods in fetchedGoods as [Goods]{
                if(info.id_goods == app.ID_selectedGoods)
                {
                    name.text = info.name_goods!
                    desc.text = info.content_desc_goods!
                    rent.text = String(Int(info.rent!))
                }
            }
        } catch {
            fatalError("Faild to fetch Goods: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartDateOnChange(sender: UIDatePicker) {
        startDate = sender.date
        print("StartDate: \(startDate)")
    }
    
    @IBAction func EndDateOnChange(sender: UIDatePicker) {
        endDate = sender.date
        print("EndDate: \(endDate)")
    }
    
    @IBAction func isAcceptOnChange(sender: UISwitch) {
        if(sender.on == true){
            isAccepet = true
        } else {
            isAccepet = false
        }
    }
    
    @IBAction func confirmOrder(sender: UIButton) {
        if(isAccepet == false){
            warnLabel.text = "请确认是否同意分享要求"
        } else {
            let appContext = app.managedObjectContext
            let newOrder = NSEntityDescription.insertNewObjectForEntityForName("Order", inManagedObjectContext: appContext) as! Order
            
            newOrder.id_order = newOrder.NumOfOrder()
            newOrder.date_startUse = startDate
            newOrder.date_endUse = endDate
            newOrder.status_order_isCompleted = false
            newOrder.status_order_isComfirmed = false
            newOrder.status_order_isGet = false
            newOrder.status_order_isReturned = false
            
            //设置订单物品为此物品
            let fetchGoodsRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
            do{
                let fetchedGoods = try appContext.executeFetchRequest(fetchGoodsRequest) as! [Goods]
                for info: Goods in fetchedGoods as [Goods] {
                    if(info.id_goods == app.ID_selectedGoods){
                        newOrder.beBorrowed = info
                        info.status_goods_isBorrowed = true
                    }
                }
            } catch {
                fatalError("Failed to fetch Goods: \(error)")
            }
            
            //设置租借者为当前用户
            let fetchUserRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
            do{
                let fetchedUser = try appContext.executeFetchRequest(fetchUserRequest) as! [User]
                for info: User in fetchedUser as [User] {
                    if(info.id_user == app.currID_user){
                        newOrder.borrow = info
                    }
                }
            } catch {
                fatalError("Failed to fetch Goods: \(error)")
            }
            
            do{
                try appContext.save()
            } catch let error as NSError{
                print("can't save NewOrder \(error.localizedDescription)")
            }
            print ("添加成功 －－－－－ func ConfirmOrder")
            
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("OrderInfo")
            self.navigationController?.pushViewController(view!, animated: true)
        }
    }
    
}
















