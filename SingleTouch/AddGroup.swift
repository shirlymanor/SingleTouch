//
//  AddGroup.swift
//  SingleTouch
//
//  Created by Shirly Manor on 7/25/16.
//  Copyright © 2016 manor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class AddGroup: UIViewController {
  
    @IBOutlet weak var newGroup: UITextField!
    @IBOutlet weak var btnAddGroup: UIButton!
    @IBAction func addGroupOnclick(sender: UIButton) {
        let ref = FIRDatabase.database().reference()
        let groupRef = ref.child("groups/")
        
        let group = newGroup.text
        let addedgroup = ["user_ids":["Shirly","Suchitra","Asha","Ozlem","Meenakshi"]]
        var nickname = ["\(group!)": addedgroup]
        groupRef.updateChildValues(nickname)
    }
}
