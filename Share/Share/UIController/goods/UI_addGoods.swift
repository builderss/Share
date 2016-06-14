//
//  Modify_goods.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class AddGoods: UIViewController {
    
    var id_goods = 0
    var inputName = ""
    var inputDesc = ""
    var inputRent = 0.0
    
    @IBOutlet weak var text_name: UITextField!
    @IBOutlet weak var text_desc: UITextField!
    @IBOutlet weak var text_rent: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: UIButton) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        
        do{
            if(app.currID_user == 0000)//确认用户已登陆
            {
                print("用户未登陆")
                
            } else {
                let newGoods = NSEntityDescription.insertNewObjectForEntityForName("Goods", inManagedObjectContext: appContext) as! Goods
                let fetchRequest_user: NSFetchRequest = NSFetchRequest(entityName: "User")
                let fetchedUser = try appContext.executeFetchRequest(fetchRequest_user) as! [User]
                
                for info: User in fetchedUser as [User]{
                    if(app.currID_user == info.id_user)//获取信息物主
                    {
                        inputName = text_name.text!
                        inputDesc = text_desc.text!
                        inputRent = Double(text_rent.text!)!
                        id_goods = newGoods.totalNumOfGoods()//查询ID
                    
                        newGoods.id_goods = id_goods
                        newGoods.name_goods = inputName
                        newGoods.content_desc_goods = inputDesc
                        newGoods.rent = inputRent
                        newGoods.status_goods_isDamaged = false
                        newGoods.status_goods_isBorrowed = false
                        newGoods.status_goods_isOnShelf = true
                        newGoods.own = info
                        
                        do{
                            try appContext.save()
                        } catch let error as NSError{
                            print("can't add newGoods \(error.localizedDescription)")
                        }
                        
                        let view = self.storyboard?.instantiateViewControllerWithIdentifier("Share")
                        self.navigationController?.pushViewController(view!, animated: true)
                        
                        //Debug
                        print("物品添加成功 ----- func addNewGoods()")
                        let count = Int((info.goods?.count)!)
                        print("物品总数：\(count)")
                    }
                }
            }
        }catch{
            fatalError("Faild to fetch User: \(error)")
        }
    }
    
}