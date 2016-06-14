//
//  myDorm.swift
//  Share
//
//  Created by Eagle on 16/6/14.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class myDorm: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var myDormTitle:[String] = []
    var myDormDesc: [NSNumber] = []
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("----------Request----------")
        
        let appContext = app.managedObjectContext
        myDormTitle = []
        myDormDesc = []
        
        let fetchGoodsRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchGoodsRequest) as! [Goods]
            for info: Goods in fetchedGoods as [Goods]{
                let address:String = (info.own?.address_loc)!
                
                if(address == "7"){
                    myDormTitle.append(info.name_goods!)
                    myDormDesc.append(info.id_goods!)
                }
            }
            print("goods name: \(myDormTitle)")
            print("goods order: \(myDormDesc)")
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
extension myDorm: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDormTitle.count
    }
    
    //单元格设置
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //标题设置为物品名
        cell.textLabel?.text = myDormTitle[index]
        //详细文本设置为订单描述
        cell.detailTextLabel!.text = String(myDormDesc[index])
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
        
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("ViewGoodsDetail")
        self.navigationController?.pushViewController(view!, animated: true)
        
    }
}