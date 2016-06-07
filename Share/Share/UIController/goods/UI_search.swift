//
//  View_searchGoods.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//
import UIKit
import CoreData
class Search: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    //origin data
    var arrTitle:[String] = []
    var arrDesc:[NSNumber] = []
    //search state
    var isSearch = false
    //search data
    var arrSearch = [String]()
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
    }
    
    override func viewDidAppear(animated: Bool) {
        let appContext = app.managedObjectContext
        
        arrTitle = []
        arrDesc = []
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Goods")
        do {
            let fetchedGoods = try appContext.executeFetchRequest(fetchRequest) as! [Goods]
            
            for info:Goods in fetchedGoods as[Goods]{
                if((info.status_goods_isBorrowed == false) && (info.status_goods_isOnShelf == true)){
                    arrTitle.append(info.name_goods!)
                    arrDesc.append(info.id_goods!)
                }
            }
            //Debug
            //print("-----------")
            //print(arrTitle[0])
        } catch {
            fatalError("Failed to fetch Goods: \(error)")
        }
        TableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*----------TableView--------*/
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        //num of Row
        if isSearch{
            return arrSearch.count
        }else{
            return arrTitle.count
        }
    }
    
    //cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) ->UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        cell.accessoryType = .DisclosureIndicator
        
        //cell data
        if isSearch{
            cell.textLabel?.text = arrSearch[index]
            cell.detailTextLabel?.text = String(arrDesc[index])
            
        }else{
            cell.textLabel?.text = arrTitle[index]
            cell.detailTextLabel?.text = String(arrDesc[index])
        }
        
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
    
    
    
/*---------SearchBar-----------*/
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        isSearch = false
        SearchBar.text = ""
        SearchBar.resignFirstResponder()
        TableView.reloadData()
    }
    
    //searchData change
    func searchBar(searchBar: UISearchBar, textDidChange searchText:String){
        
        onSearch(searchText)
    }
    
    //virtual keyBoard search
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        print("search Button")
        onSearch(SearchBar.text!)
        //关闭虚拟键盘
        SearchBar.resignFirstResponder()
    }
    
    
    //search method
    func onSearch(str: String){
        
        isSearch = true
        arrSearch = [String]()
        for title in arrTitle{
            let index = title.rangeOfString(str)
            if (index?.isEmpty != nil) {
                self.arrSearch.append(title)
            }
        }
        TableView.reloadData()
    }
    
}