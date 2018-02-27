//
//  YesNoPromptViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/18/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class YesNoPromptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if let url = URL(string: "http://pikanite.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   

}
