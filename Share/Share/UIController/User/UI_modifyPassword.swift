//
//  UI_modifyPassword.swift
//  Share
//
//  Created by Eagle on 16/5/14.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ModifyPassword: UIViewController {
    
    @IBOutlet weak var currPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var checkPasswordText: UITextField!
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
        
        let oldPassword  = currPasswordText.text
        let newPassword = newPasswordText.text
        let checkPassword = checkPasswordText.text
        
        if(newPassword == checkPassword){
            let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        /*
             1.检测新密码是否一直
             2.如果新密码一致，检测旧密码，否则提示错误
             3.如果旧密码一致，更改密码并保存，返回根界面；否则提示错误，清空新密码合确认密码
        */
            
            do {
                let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
                for info:User in fetchedUser as[User]{
                    if info.id_user == app.currID_user {
                    
                        if(oldPassword == info.password){
                            info.password = newPassword
                            do {
                                try appContext.save()
                            } catch let error as NSError{
                                print("can't save \(error.localizedDescription)")
                            }
                            
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        } else {
                            warnLabel.text = "当前密码输入错误"
                            newPasswordText.text = ""
                            checkPasswordText.text = ""
                        }
                        //Debug
                        print("password: \(info.password)")
                    }
                }
            } catch {
                fatalError("Failed to fetch User: \(error)")
            }
        } else {
            warnLabel.text = "密码不一致"
        }
        
    }
}
