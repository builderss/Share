//
//  UI_returnOrder.swift
//  Share
//
//  Created by Eagle on 16/5/29.
//  Copyright © 2016年 myCompany. All rights reserved.
//
import UIKit
import CoreData

class ReturnOrder: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var myReturnTitle:[String] = []
    var myReturnDesc: [NSNumber] = []
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("----------Request----------")
        
        let appContext = app.managedObjectContext
        myReturnTitle = []
        myReturnDesc = []
        
        let fetchUserRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do{
            let fetchedUser = try appContext.executeFetchRequest(fetchUserRequest) as! [User]
            for info_User: User in fetchedUser as [User]{
                
                if(info_User.id_user == app.currID_user){
                    let UserGoods = info_User.goods?.allObjects
                    for goods: Goods in UserGoods as! [Goods]{
                        
                        if(goods.status_goods_isBorrowed == true){
                            let goodsOrder = goods.order?.allObjects
                            for order: Order in goodsOrder as! [Order]{
                                
                                if(order.status_order_isCompleted == false){
                                    if(order.status_order_isComfirmed == true){
                                        if(order.status_order_isGet == true){
                                           if(order.status_order_isReturned == false){
                                             myReturnTitle.append(goods.name_goods!)
                                                myReturnDesc.append(order.id_order!)
                                            } 
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            print("goods name: \(myReturnTitle)")
            print("goods order: \(myReturnDesc)")
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*----TableView----*/
extension ReturnOrder: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReturnTitle.count
    }
    
    //单元格设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //标题设置为物品名
        cell.textLabel?.text = myReturnTitle[index]
        //详细文本设置为订单描述
        cell.detailTextLabel!.text = String(myReturnDesc[index])
        cell.accessoryType = .DisclosureIndicator
        //缩略图设置为物品照片
        //cell.imageView.image = arrImage[Index]
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //获得点击的内容
        let cell: UITableViewCell! = tableView.cellForRowAtIndexPath(indexPath)
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.ID_selectedOrder = Int((cell.detailTextLabel?.text)!)!
        print(app.ID_selectedOrder)
        
        
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmReturn")
        self.navigationController?.pushViewController(view!, animated: true)
        
        
    }
}