//
//  Modify_userInfo.swift
//  Share
//
//  Created by Eagle on 16/5/1.
//  Copyright © 2016年 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ModifyAddress: UIViewController {
    
    @IBOutlet weak var schoolText: UITextField!
    @IBOutlet weak var gardenText: UITextField!
    
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
        
        let school: String = schoolText.text!
        let garden: String = gardenText.text!
        let address: String = school + garden
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUser = try appContext.executeFetchRequest(fetchRequest) as! [User]
            for info:User in fetchedUser as[User]{
                if info.id_user == app.currID_user {
                    
                    info.address_loc = address
                    do {
                        try appContext.save()
                    } catch let error as NSError{
                        print("can't save \(error.localizedDescription)")
                    }
                    //Debug
                    print(info.address_loc)
                }
            }
        self.navigationController?.popToRootViewControllerAnimated(true)
        } catch {
            fatalError("Failed to fetch User: \(error)")
        }
    }
}
