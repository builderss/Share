//
//  View_singleGoods.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewGoodsDetail: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var rent: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var order: NSLayoutConstraint!
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = CGSizeMake(300, 500)
        
        
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
                    
                    if(info.status_goods_isBorrowed == false){
                        state.text = "可借"
                        order.isAccessibilityElement = true
                        if(info.own?.id_user == app.currID_user){
                            order.isAccessibilityElement = false
                        }
                    } else {
                        state.text = "不可借"
                        order.isAccessibilityElement = false
                    }
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
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBAction func orderAction(sender: AnyObject) {
        if(app.currID_user == 0000){
            warnLabel.textColor = UIColor.greenColor()
            warnLabel.text = "请先登录"
        } else {
            if(order.isAccessibilityElement == true){
                let view = self.storyboard?.instantiateViewControllerWithIdentifier("GetGoods")
                self.navigationController?.pushViewController(view!, animated: true)
            } else {
                warnLabel.textColor = UIColor.redColor()
                warnLabel.text = "此物品不可借"
            }
        }
    }
}









