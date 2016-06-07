//
//  view_myGoods.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class Share: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var myShareTitle:[String] = []
    var myShareDesc: [NSNumber] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("---------\(segmentedControl.selectedSegmentIndex)-----------")
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        myShareTitle = []
        myShareDesc = []
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as[User]{
                if(info.id_user == app.currID_user){
                    if(segmentedControl.selectedSegmentIndex == 0){
                        let myShare = info.goods?.allObjects
                        for good: Goods in myShare as! [Goods]{
                            myShareTitle.append(good.name_goods!)
                            myShareDesc.append(good.id_goods!)
                        }
                    }
                    if(segmentedControl.selectedSegmentIndex == 1){
                        let myBorrow = info.order?.allObjects
                        for orders: Order in myBorrow as! [Order]{
                            if (orders.status_order_isCompleted == false){
                                myShareTitle.append((orders.beBorrowed?.name_goods!)!)
                                myShareDesc.append((orders.beBorrowed?.id_goods!)!)
                            }
                        }
                    } 
                }
            }
            print("good's name: \(myShareTitle)")
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*--Debug Begin--*/
    @IBAction func share(sender: AnyObject) {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchRequest) as! [Goods]
            print("----------------")
            for info:Goods in fetchedGoods as [Goods]{
                print("goodsID: \(info.id_goods)")
                print("goodsOwner: \(info.own?.id_user)")
                print("goodsName: \(info.name_goods)")
                //delete
                /*if(info.own == nil){
                    appContext.deleteObject(info)
                }*/
                
            }
            //save delete
            do{
                try appContext.save()
            } catch let error as NSError{
                print("can't add newGoods \(error.localizedDescription)")
            }
            
        }catch {
            fatalError("Failed to fetch Goods \(error)")
        }
    }
    /*--Debug End--*/
}


/*-----segment Begin-----*/
extension Share{
    @IBAction func segment(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        myShareTitle = []
        myShareDesc = []
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as[User]{
                if(info.id_user == app.currID_user){
                    if(sender.selectedSegmentIndex == 0){
                        let myShare = info.goods?.allObjects
                        for good: Goods in myShare as! [Goods]{
                            myShareTitle.append(good.name_goods!)
                            myShareDesc.append(good.id_goods!)
                        }
                    }
                    if(sender.selectedSegmentIndex == 1){
                        let myBorrow = info.order?.allObjects
                        for orders: Order in myBorrow as! [Order]{
                            if (orders.status_order_isCompleted == false){
                                myShareTitle.append((orders.beBorrowed?.name_goods!)!)
                                myShareDesc.append((orders.beBorrowed?.id_goods!)!)
                            }
                        }
                    }
                    print("good's name: \(myShareTitle)")
                }
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        tableView.reloadData()
    }
}


/*----TableView----*/
extension Share: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myShareTitle.count
    }
    
    //单元格设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //标题设置为物品名
        cell.textLabel?.text = myShareTitle[index]
        //详细文本设置为物品描述
        cell.detailTextLabel!.text = String(myShareDesc[index])
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
        app.ID_selectedGoods = Int((cell.detailTextLabel?.text)!)!
        print(app.ID_selectedGoods)
        
        if(segmentedControl.selectedSegmentIndex == 0){
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("ViewMyShare")
            self.navigationController?.pushViewController(view!, animated: true)
        }
        if(segmentedControl.selectedSegmentIndex == 1){
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("ViewMyBorrow")
            self.navigationController?.pushViewController(view!, animated: true)
        }
        
    }
}









