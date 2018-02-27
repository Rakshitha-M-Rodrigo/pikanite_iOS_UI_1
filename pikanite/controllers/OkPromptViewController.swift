//
//  OkPromptViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/18/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class OkPromptViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var titleMessage: String = ""
    var errorMessage: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.titleLabel.text = self.titleMessage
        self.descriptionLabel.text = self.errorMessage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
