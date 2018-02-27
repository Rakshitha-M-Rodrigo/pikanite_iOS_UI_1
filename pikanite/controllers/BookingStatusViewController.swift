//
//  BookingStatusViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/18/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class BookingStatusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
            print("booking success")
            self.closeView()
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
