//
//  FAQViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/20/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var faq1View: UIView!
    @IBOutlet weak var faq1HeightConstraints: NSLayoutConstraint!
    
 
    
    
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
    
    @IBAction func faq1ButtonPressed(_ sender: Any) {
//        self.faq1View.alpha = 0
//        self.faq1HeightConstraints.priority = UILayoutPriority.init(rawValue: 999.00)
//        self.faq1View.frame.size.height = 2
        
        
    }
    
    @IBAction func faq2ButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func faq3ButtonPressed(_ sender: Any) {
    }
    
    @IBAction func faq4ButtonPressed(_ sender: Any) {
    }
    
    @IBAction func faq5ButtonPressed(_ sender: Any) {
    }
    
    @IBAction func faq6ButtonPressed(_ sender: Any) {
    }
    
    @IBAction func faq7ButtonPressed(_ sender: Any) {
    }
    
    @IBAction func faq8ButtonPressed(_ sender: Any) {
    }
    
    
    
    
    
    
}
