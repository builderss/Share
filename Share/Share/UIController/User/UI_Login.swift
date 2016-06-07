//
//  Login.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class Login: UIViewController {
    
    var inputID = 0000
    var inputPawd = "0000"
    
    @IBOutlet weak var id_login: UITextField!
    @IBOutlet weak var pawd_login: UITextField!
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        inputID = Int(id_login.text!)!
        inputPawd = pawd_login.text!
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as[User]{
                if(info.id_user == inputID){
                    if(info.password == inputPawd){
                        app.currID_user = inputID
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        //Test info
                        print("success")
                        print(String(app.currID_user))
                    } else{
                        print("wrong password")
                    }
                }
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    @IBAction func regist(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            print("------------------")
            for info:User in fetchedUser as[User]{
                print("id_user = \(info.id_user)")
                print("password = \(info.password)")
                
                 /*if info.id_user == 0000 {
                    appContext.deleteObject(info)
                    do {
                        try appContext.save()
                    } catch let error as NSError{
                        print("can't save \(error.localizedDescription)")
                    }
                 }
                */
            }
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
    }
    
}
