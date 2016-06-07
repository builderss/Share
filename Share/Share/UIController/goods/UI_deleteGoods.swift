//
//  UI_modifyName.swift
//  Share
//
//  Created by Eagle on 16/5/18.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class DeleteGoods: UIViewController {
    
    var password = ""
    
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsStatus: UILabel!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var warnLabel: UILabel!
    
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
                if(app.ID_selectedGoods == info.id_goods){
                    goodsName.text = info.name_goods
                    if(info.status_goods_isBorrowed == false){
                        goodsStatus.text = "可借"
                    } else {
                        goodsStatus.text = "已借出"
                    }
                    
                }
            }
        } catch {
            fatalError("Failed to fetch GoodsInfo: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmDelete(sender: UIButton) {
        password = pwdText.text!
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        let fetchUserRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do{
            let fetchedUser = try appContext.executeFetchRequest(fetchUserRequest) as! [User]
            for info:User in fetchedUser as [User]{
                if(info.id_user == app.currID_user){
                    if(info.password == password){
                        //删除物品
                        let fetchGoodsRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
                        do{
                            let fetchedGoods = try appContext.executeFetchRequest(fetchGoodsRequest) as! [Goods]
                            for info: Goods in fetchedGoods as [Goods]{
                                if(app.ID_selectedGoods == info.id_goods){
                                    info.status_goods_isOnShelf = false
                                    print("delete:  \(info.name_goods) \(info.id_goods)")
                                    do {
                                        try appContext.save()
                                    } catch let error as NSError{
                                        print("delete failed: \(error.localizedDescription)")
                                    }
                                    self.navigationController?.popToRootViewControllerAnimated(true)
                                }
                            }
                        } catch {
                            fatalError("Failed to fetch GoodsInfo: \(error)")
                        }
                        
                    } else {
                        warnLabel.text = "密码错误"
                    }
                }
            }
        } catch {
            fatalError("Failed to fetch UserInfo: \(error)")
        }
    }
    
    
}