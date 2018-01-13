//
//  LoginViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/11/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var signInButtonView: UIView!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var pikaniteLogoImageView: UIImageView!
    @IBOutlet weak var signInFacebookButtonView: UIView!
    @IBOutlet weak var signInGoogleButtonView: UIView!
    @IBOutlet weak var orSeparatorView: UIView!
    @IBOutlet weak var standardSignInButtonView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainContainer.alpha = 1
        self.pikaniteLogoImageView.alpha = 0
        self.signInFacebookButtonView.alpha = 0
        self.signInGoogleButtonView.alpha = 0
        self.orSeparatorView.alpha = 0
        self.standardSignInButtonView.alpha = 0
        self.createAccountView.alpha = 0

        self.signInButtonView.layer.borderColor = UIColor.white.cgColor
        self.signInButtonView.layer.borderWidth = 2
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
            self.pikaniteLogoImageView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.3, options: .curveEaseInOut, animations: {
            self.signInFacebookButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.6, options: .curveEaseInOut, animations: {
            self.signInGoogleButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.8, options: .curveEaseInOut, animations: {
            self.orSeparatorView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
            self.standardSignInButtonView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 2.2, options: .curveEaseInOut, animations: {
            self.createAccountView.alpha = 1
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
