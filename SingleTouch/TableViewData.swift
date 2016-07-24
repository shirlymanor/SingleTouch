//
//  TableViewData.swift
//  SingleTouch
//
//  Created by Shirly Manor on 7/23/16.
//  Copyright © 2016 manor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewData: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("******")
        //var names = [String]()
        getUsersByGroupID("family")
    }

    
    var usernames: [String] = [] {
        didSet {
            print(" user names set to \(usernames)")
            //mytableview.reloadData()
        }
    }
    
    func getUsersByGroupID(groupID : String) {
        let ref = FIRDatabase.database().reference()
        ref.child("groups/family/user_ids").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            self.usernames = snapshot.value as! [String]
        })
    }

}
