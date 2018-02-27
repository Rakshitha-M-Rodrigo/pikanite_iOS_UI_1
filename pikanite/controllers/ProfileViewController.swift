//
//  ProfileViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/22/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userTelePhoneNumberTextField: UITextField!
    @IBOutlet weak var userBirthdayTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userEmailTextField.text = UserDefaults.standard.string(forKey: "userEmail")
        self.userNameTextField.text = UserDefaults.standard.string(forKey: "UserName")
//        self.userPhoneNumberLabel.text = ""
        //        self.birthdayLabel.text =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
