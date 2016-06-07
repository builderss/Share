//
//  Regist.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Regist: UIViewController {

    var inputName = ""
    var inputID = 00000
    var inputAddress = ""
    var inputPhoneNum = 6
    var inputPassword = ""
    var inputPasswordCorrect = ""
    var isRegisted = false
    
    @IBOutlet weak var name_user: UITextField!
    @IBOutlet weak var id_user: UITextField!
    @IBOutlet weak var address_loc: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordCorrect: UITextField!
    @IBOutlet weak var warnLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let appContext = app.managedObjectContext
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appContext) as! User

        inputName = name_user.text!
        inputID = Int(id_user.text!)!
        inputAddress = address_loc.text!
        inputPhoneNum = Int(phoneNumber.text!)!
        inputPassword = password.text!
        inputPasswordCorrect = passwordCorrect.text!
        
        //检测用户名
        if newUser.isRegisted(inputID){
            warnLabel.textColor = UIColor.redColor()
            warnLabel.text = "用户名已被注册"
        } else {
            //核对密码
            if(inputPassword == inputPasswordCorrect){
                
                newUser.id_user = inputID
                newUser.password = inputPassword
                newUser.name_user = inputName
                newUser.address_loc = inputAddress
                newUser.phoneNumber = inputPhoneNum
                
                do{
                    try appContext.save()
                } catch  let error as NSError{
                    print("can't save NewUser \(error.localizedDescription)")
                }
                print ("添加成功 －－－－－ func addNewUser()")
                
                warnLabel.textColor = UIColor.greenColor()
                warnLabel.text = "注册成功"
                
            } else {
                warnLabel.textColor = UIColor.redColor()
                warnLabel.text = "密码不一致"
            }
        }
    }
    
    
}

