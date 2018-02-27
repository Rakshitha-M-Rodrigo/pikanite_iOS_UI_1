//
//  SignUpViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/7/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.appDelegate.userAgreement){
            self.appDelegate.userAgreement = false
            UserDefaults.standard.set(false, forKey: "joiningAgreement")
            self.promptJoiningAgreement(logginType: "generic")
        } else {
            self.promptJoiningAgreement(logginType: "generic")
            //GIDSignIn.sharedInstance().signIn()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if ( self.userNameTextField.text != "" && self.userPasswordTextField.text != "" && userPasswordTextField.text != ""){
            //        let name = self.userNameTextField.text
            let email = self.userEmailTextField.text
            //        let password = self.userPasswordTextField.text
            
            self.checkUser(email: email!)
        } else {
            self.displayAlertWithOk(title: "Pikanite Alert!", alertMessage: "Please fill the all infomations...")
        }

    }
    @IBAction func SignInButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "SignInViewController")
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkUser(email: String){
        UserHelper.checkUser(email: email) { (success, resposnse, errors) in
            if (errors == nil){
                let status = (resposnse!.dictionaryObject)!["message"]! as! String
                
                if (status == "failed"){
                    print("===> user does not exist")
                    self.registerNewUser(name: self.userNameTextField.text!, email: self.userEmailTextField.text!, password: self.userPasswordTextField.text!)
                } else if (status == "success"){
                    let content = (resposnse!.dictionaryObject)!["content"]! as! [String: Any]
                    print("===> user exist")
                    print(content["name"] as! String)
                    self.displayAlertWithOk(title: "Pikanite Alert!", alertMessage: "This email already exist!, Please use signIn or forgot password to reset new passphrase, incase if you have forgotten the logging combination.")
                }
            }
        }
    }
}
