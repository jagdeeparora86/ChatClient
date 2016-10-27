//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Singh, Jagdeep on 10/26/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        getMessages()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: "getMessages", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var messages = [String]()
    var user = [String]()
    func getMessages(){
        var query = PFQuery(className: "Message")
        
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                if let objects = objects {
                    for object in objects{
                        
                        if object["text"] != nil {
                            print(object["text"])
                            self.messages.append(object["text"]! as! String)
                        }
                        
                        if(object["user"] != nil){
                            let user = object["user"] as! PFUser
                            self.user.append(user.username!)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func sendChat(_ sender: AnyObject) {
        var groupMessage = PFObject(className: "Message")
        groupMessage["text"]  = chatTextField.text!
        groupMessage["user"] = PFUser.current()
        groupMessage.saveInBackground { (succeeded, error) in
            if(error == nil){
                print("we posted succesfully")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row]
        cell.userLabel.text = user[indexPath.row]
        
        return cell
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

