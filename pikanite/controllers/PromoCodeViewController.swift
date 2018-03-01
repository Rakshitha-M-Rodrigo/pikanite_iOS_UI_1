//
//  PromoCodeViewController.swift
//  pikanite
//
//  Created by Achsuthan Mahendran on 2/28/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

protocol PromocodeProtocol {
    func setPromoCode(valueSent: [String: Double])
}

class PromoCodeViewController: BaseViewController {
    
    var delegate:PromocodeProtocol?
    
    @IBOutlet weak var txtPromoCode: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //delegate?.setPromoCode(valueSent: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btVerify(_ sender: Any) {
        print("----- Verify button clicked ----")
        self.txtPromoCode.resignFirstResponder()
        
        let promo = self.txtPromoCode.text
        
        if ( self.txtPromoCode.text != "" && self.txtPromoCode.text != ""){
            self.checkPromo(code: promo!)
        } else {
            self.displayAlertWithOk(title: "Pikanite Alert!", alertMessage: "Please fill the all infomations...")
        }
        
        
        //go back to hotel page when the verify success
        //_ = self.navigationController?.popViewController(animated: true)
    }
    
    //Disable the keyboard when the user touch the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch began")
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func checkPromo(code: String){
        self.showActivityIndicator()
        UserHelper.checkPromoCode(promoCode: code) { (success, resposnse, errors) in
            if (errors == nil){
                let status = (resposnse!.dictionaryObject)!["message"]! as! String
                
                if (status == "failed"){
                    print("===> user does not exist")
                    self.hideActivityIndicator()
                    self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite Says!, This is an invalid promo code.")
                } else if (status == "success"){
                    self.hideActivityIndicator()
                    print("Success with the getting the promo code")
                    print("Responce \(String(describing: resposnse))")
                    print("Amount \(resposnse!["amount"])")
                    print("Percentage \(resposnse!["percentage"])")
                    self.appDelegate.promoCode = code
                    let percentage = (resposnse!.dictionaryObject!)["percentage"] as? Double!
                    let amount = (resposnse!.dictionaryObject!)["amount"] as? Double!
                    
                    self.appDelegate.promoValues = ["Amount": amount!, "Percentage": percentage!]
                    self.delegate?.setPromoCode(valueSent: ["Amount": amount!, "Percentage": percentage!])
                    //go back to hotel page when the verify success
                   self.dismiss(animated: true, completion: nil)
                    
                }
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Opps!", alertMessage: "Pikanite Says!, Some thing went wrong!")
            }
        }
    }
    
 
}

