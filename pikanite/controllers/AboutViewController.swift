//
//  AboutViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/20/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func aboutUsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "AboutUsViewController")
    }
    
    @IBAction func privacyPolicyButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "PrivacyPolicyViewController")
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "TermsOfUseViewController")
    }
    
    @IBAction func hotelSignUPButtonPressed(_ sender: Any) {
        if let url = URL(string: "http://partner.pikanite.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
