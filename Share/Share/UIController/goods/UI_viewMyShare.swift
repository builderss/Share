//
//  UI_viewMyShare.swift
//  Share
//
//  Created by Eagle on 16/5/16.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewMyShare: UIViewController {
    
    var canDrop = true
    var canCallBack = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsDesc: UILabel!
    @IBOutlet weak var goodsState: UILabel!
    @IBOutlet weak var warnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = CGSizeMake(300, 650)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do{
            let fetchedGoods = try appContext.executeFetchRequest(fetchRequest) as! [Goods]
            for info: Goods in fetchedGoods as [Goods]{
                if(app.ID_selectedGoods == info.id_goods){
                    goodsName.text = info.name_goods
                    goodsDesc.text = info.content_desc_goods
                    if(info.status_goods_isBorrowed == true){
                        goodsState.text = "借出"
                        canDrop = false
                        canCallBack = true
                        
                    } else {
                        goodsState.text = "可借"
                        canDrop = true
                    }
                    if(info.status_goods_isOnShelf == false){
                        goodsState.text = "已下架"
                        canDrop = false
                    }
                    
                }
            }
        } catch {
            fatalError("Failed to fetch GoodsInfo: \(error)")
        }
    }
    
    
    @IBAction func callBack(sender: UIButton) {
        if(canCallBack){
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("CallBack")
            self.navigationController?.pushViewController(view!, animated: true)
        } else {
            goodsState.text = "物品未借出"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dropGoods(sender: AnyObject) {
        if(canDrop){
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("DeleteGoods")
            self.navigationController?.pushViewController(view!, animated: true)
        } else {
            warnLabel.text = "已下架或已借出"
        }
    }
}


















