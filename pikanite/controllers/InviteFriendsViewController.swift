//
//  InviteFriendsViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/19/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class InviteFriendsViewController: BaseViewController {

    let name: String = UserDefaults.standard.string(forKey: "profileName")!
    let promotionKey = "PIKANITE1020"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareMyLink(_ sender: Any) {
//        UIPasteboard.general.string = self.promoCodeTextField.text ?? ""
//        self.showAlert(message: "Promo code copied to clipboard!")
        var shareText = ""
        shareText = "\(name) invited you to Pikanite. Install the app via pikanite.com. Use the promotion key \(promotionKey) when you register."
        
        DispatchQueue.main.async {
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
