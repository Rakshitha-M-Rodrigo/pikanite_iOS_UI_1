//
//  AgreementViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/6/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class AgreementViewController: BaseViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var logginType: String = ""
    let destinationViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.acceptButton.isEnabled = false
        self.declineButton.isEnabled = false
        self.acceptButton.alpha = 0.4
        self.declineButton.alpha = 0.4

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func declineButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "joiningAgreement")
        self.appDelegate.loginHandler()
    }
    @IBAction func acceptedButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "joiningAgreement")
        
        if (logginType != ""){
            switch logginType {
            case "facebook":
                self.destinationViewController.loginButtonClicked()
            case "google":
                self.destinationViewController.googleLogginButtonClicked()
            case "generic":
                self.dismiss(animated: true, completion: nil)
            default:
                //generic
                print("generic")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        //self.dismiss(animated: true, completion: nil)
        
    }
}


extension AgreementViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let scrollPercentage = (contentOffset/self.scrollView.bounds.height) * 100
        
        if (scrollPercentage>95){
            UIView.animate(withDuration: 0.4, animations: {
                self.acceptButton.alpha = 1
                self.declineButton.alpha = 1
            })
            
            self.acceptButton.isEnabled = true
            self.declineButton.isEnabled = true
        }
    }
}
