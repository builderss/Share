//
//  UI_orderHistory.swift
//  Share
//
//  Created by Eagle on 16/5/30.
//  Copyright © 2016年 myCompany. All rights reserved.
//
import UIKit
import CoreData

class OrderHistoty: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var myHistoryTitle:[String] = []
    var myHistoryDesc: [NSNumber] = []
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("----------Request----------")
        
        let appContext = app.managedObjectContext
        myHistoryTitle = []
        myHistoryDesc = []
        
        let fetchUserRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do{
            let fetchedUser = try appContext.executeFetchRequest(fetchUserRequest) as! [User]
            for info_User: User in fetchedUser as [User]{
                
                let orders = info_User.order?.allObjects
                for order: Order in orders as! [Order]{
                    if(order.status_order_isCompleted == true){
                        myHistoryTitle.append((order.beBorrowed?.name_goods)!)
                        myHistoryDesc.append(order.id_order!)
                    }
                }
            }
            print("goods name: \(myHistoryTitle)")
            print("goods order: \(myHistoryDesc)")
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
extension OrderHistoty: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myHistoryTitle.count
    }
    
    //单元格设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //标题设置为物品名
        cell.textLabel?.text = myHistoryTitle[index]
        //详细文本设置为订单描述
        cell.detailTextLabel!.text = String(myHistoryDesc[index])
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
        
    }
}