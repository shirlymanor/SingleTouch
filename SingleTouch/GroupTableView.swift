//
//  GroupTableView.swift
//  SingleTouch
//
//  Created by Shirly Manor on 7/23/16.
//  Copyright © 2016 manor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON

class GroupTableView: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroups()
        // getUsersByGroupID("ios")
        
    }
    //    enum groupId{
    //         ios,
    //        family,
    //        friends
    //    }
    var usernames: [String] = [] {
        didSet {
            print(" user names set to \(usernames)")
            self.tableView.reloadData()
        }
    }
    
    var phoneNumbers: [String] = []{
        didSet {
            print(" phonenumber \(phoneNumbers)")
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("users count set to \(usernames.count)")
        return usernames.count
    }
    var flag = true
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath)
        cell.textLabel?.text = usernames[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        //let cell1 = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath)
        //cell1.textLabel?.text = usernames[indexPath.row]
        getUsersByGroupID(usernames[indexPath.row])
    }
    
    func getUsersByGroupID(groupID : String)
    {
        let ref = FIRDatabase.database().reference()
        print("groups/\(groupID)/user_ids")
        ref.child("groups/\(groupID)/user_ids").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let groups = snapshot.value as! [String]
            self.usernames = groups
            
            for (uname) in groups{
                print("users/\(uname)/phone_number")
                ref.child("users/\(uname)/phone_number").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    guard let phoneNumber: String? = snapshot.value as! String else { return }
                    self.phoneNumbers.append(phoneNumber!)
                })
                
            }
            
        })
    }
    func setGroups()
    {
        let ref = FIRDatabase.database().reference()

        let groupRef = ref.childByAppendingPath("groups")
        let family = ["user_ids":["alan","ppp"]]
        let friends = ["user_ids":["grace","alan","Shirly"]]
        let ios = ["user_ids":["Shirly","Suchitra","Asha","Ozlem","Meenakshi"]]
        
        let groups = ["family": family, "friends": friends, "ios": ios]
        groupRef.setValue(groups)
    }
    func getGroups()
    {
        let ref = FIRDatabase.database().reference()
        ref.child("groups").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            var groups = snapshot.value as! [String: AnyObject]
            var groupName = [String]()
            for (name, value) in groups {
                groupName.append(name)
            }
            self.usernames = groupName
        })
    }
}

