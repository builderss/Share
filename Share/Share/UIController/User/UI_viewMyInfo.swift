//
//  View_userInfo.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewMyInfo: UIViewController {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var textID: UILabel!
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textGrade: UILabel!
    @IBOutlet weak var textRank: UILabel!
    @IBOutlet weak var textCredit: UILabel!
    @IBOutlet weak var textAddress: UILabel!
    @IBOutlet weak var textPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appContext = app.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do{
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as [User]{
                if(app.currID_user == info.id_user){
                    
                    let Id = Int(info.id_user!)
                    let name = info.name_user
                    let grade = Int(info.grade!)
                    let rank = Int(info.rank!)
                    let address = info.address_loc
                    let credit = Int(info.credit!)
                    let phoneNum = Int(info.phoneNumber!)
                    
                    textID.text = String(Id)
                    textName.text = name
                    textGrade.text = String(grade)
                    textRank.text = String(rank)
                    textCredit.text = String(credit)
                    textAddress.text = address
                    textPhone.text = String(phoneNum)
                }
            }
        } catch{
            fatalError("Failed to fetch UserInfo: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}