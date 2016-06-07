//
//  UI_modifyPhoneNum.swift
//  Share
//
//  Created by Eagle on 16/5/14.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ModifyPhoneNumber: UIViewController {
    
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var warnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmModify(sender: AnyObject) {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        
        let phoneNum = Int(phoneNumText.text!)
        let password = passwordText.text!
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as[User]{
                if info.id_user == app.currID_user {
                    
                    if(password == info.password){
                        info.phoneNumber = phoneNum
                        
                        do {
                            try appContext.save()
                        } catch let error as NSError{
                            print("can't save \(error.localizedDescription)")
                        }
                        
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    } else {
                        warnLabel.text = "密码错误"
                    }
                    //Debug
                    print("PhoneNum: \(info.phoneNumber)")
                }
            }
            
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
    }
}
