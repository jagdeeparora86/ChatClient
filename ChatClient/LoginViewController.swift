//
//  LoginViewController.swift
//  ChatClient
//
//  Created by Singh, Jagdeep on 10/26/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        var user = PFUser()
        
    }
    
    @IBAction func handleSignUp(_ sender: AnyObject) {
        var user = PFUser()
        user.username = emailField.text!
        user.password = passwordField.text!
        user.email = emailField.text!
        user.signUpInBackground { (succeeded, error) in
            if(!(error != nil)){
                self.dologin()
            }
            else{
                
            }
        }
    }
    
    

    @IBAction func handleLogin(_ sender: AnyObject) {
        var user = PFUser()
        user.username = emailField.text!
        user.password = passwordField.text!
        user.email = emailField.text!
        
        
    }
    
    func dologin(){
        PFUser.logInWithUsername(inBackground: emailField.text!, password: passwordField.text!) { (user, error) in
            if(user != nil ){
                var alert = UIAlertController(title: "Success", message: "logged in", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }

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
