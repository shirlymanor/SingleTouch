//
//  ViewController.swift
//  SingleTouch
//
//  Created by Shirly Manor on 7/23/16.
//  Copyright © 2016 manor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("******")
        updateFirebase()
        //var names = [String]()
        
        getUsersByGroupID("family")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateFirebase()
    {
        let ref = FIRDatabase.database().reference()
        
        let groupRef = ref.childByAppendingPath("groups")
        let family = ["user_ids":["alan","ppp"]]
        let friends = ["user_ids":["grace","alan","Shirly"]]
        let ios = ["user_ids":["Shirly","Suchitra","Asha","Ozlem","Meenakshi"]]
        
        let groups = ["family": family, "friends": friends, "ios": ios]
        
        
        let alanisawesome = ["full_name": "Alan Turing", "phone_number": "333-444-5555"]
        let gracehop = ["full_name": "Grace Hopper", "phone_number": "555-444-7777"]
        let shirly = ["full_name": "Shirly", "phone_number": "516-382-6164"]
        let suchitra = ["full_name": "Suchitra", "phone_number": "666-2426-015"]
        let Asha = ["full_name": "Asha", "phone_number": "408-821-3448"]
        let Ozlem = ["full_name": "Ozlem", "phone_number": "803-447-2566"]
        let Meenakshi = ["full_name": "Meenakshi", "phone_number": "408-569-6648"]
        
        let usersRef = ref.childByAppendingPath("users")
        let users = ["alanisawesome": alanisawesome, "gracehop": gracehop, "Meenakshi":Meenakshi,"Ozlem":Ozlem, "Asha": Asha, "shirly":shirly, "suchitra":suchitra]
        
        usersRef.setValue(users)
        groupRef.setValue(groups)
    }
    
    var usernames: [String] = [] {
        didSet {
            print(" user names set to \(usernames)")
        }
    }
    
   
    
    func getUsersByGroupID(groupID : String)
    {
        let ref = FIRDatabase.database().reference()
        ref.child("groups/family/user_ids").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            self.usernames = snapshot.value as! [String]
        })
    }
   
}

