//
//  UI_viewMyBorrow.swift
//  Share
//
//  Created by Eagle on 16/5/16.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewMyBorrow: UIViewController {
    
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsOwner: UILabel!
    @IBOutlet weak var ownerTelNum: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var goodsStatus: UILabel!
    
    var canReturn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let fetchGoodsRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchGoodsRequest) as! [Goods]
            for info: Goods in fetchedGoods as [Goods]{
                if(info.id_goods == app.ID_selectedGoods){
                    goodsName.text = info.name_goods
                    goodsOwner.text = info.own?.name_user
                    ownerTelNum.text = String(Int((info.own?.phoneNumber)!))
                    
                    let orders = info.order?.allObjects
                    for order: Order in orders as! [Order]{
                        if(order.status_order_isCompleted == false){
                            startTime.text = String(order.date_startUse)
                            endTime.text = String(order.date_endUse)
                            
                            if(order.status_order_isComfirmed == false){
                                goodsStatus.text = "请求待确认"
                            }
                            if(order.status_order_isComfirmed == true){
                                if(order.status_order_isGet == false){
                                    goodsStatus.text = "待收货"
                                }
                                if(order.status_order_isGet == true){
                                    goodsStatus.text = "使用中"
                                    canReturn = true
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            fatalError("failed to fetch Goods \(error)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBAction func Return(sender: AnyObject) {
        if(canReturn == true){
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("ReturnGoods")
            self.navigationController?.pushViewController(view!, animated: true)
        } else {
            warnLabel.textColor = UIColor.redColor()
            warnLabel.text = "物品未送达"
        }
        
    }

    
}