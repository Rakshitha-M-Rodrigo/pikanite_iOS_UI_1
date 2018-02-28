//
//  PromoCodeViewController.swift
//  pikanite
//
//  Created by Achsuthan Mahendran on 2/28/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class PromoCodeViewController: BaseViewController {
    
    @IBOutlet weak var txtPromoCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
                    print("Persentage \(resposnse!["percentage"])")
                    
                    
                    //go back to hotel page when the verify success
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
            } else {
                self.hideActivityIndicator()
                self.displayAlertWithOk(title: "Opps!", alertMessage: "Pikanite Says!, Some thing went wrong!")
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

