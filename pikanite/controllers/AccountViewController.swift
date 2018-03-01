//
//  AccountViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/23/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn
import SDWebImage
import MessageUI


class AccountViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var headerCurve: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: Variable
    
    var picURL: String = ""
    var name: String = ""
    let dummy = "User"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.performLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerCurve.layer.cornerRadius = self.headerCurve.bounds.width / 1.9
        self.performLoading()
    }

    func performLoading(){
        self.showActivityIndicator()
        if ((UserDefaults.standard.string(forKey: "profileImageURL"))! != nil){
            
            self.picURL = (UserDefaults.standard.string(forKey: "profileImageURL"))!
        }
        
        if (UserDefaults.standard.string(forKey: "profileName")! != nil ){
            self.name = UserDefaults.standard.string(forKey: "profileName")!
        }
        
        if(name != ""){
            self.nameLabel.text = "Hi! \(name)"
        } else {
            self.nameLabel.text = "Hi! \(dummy)"
        }
        
        if(picURL != ""){
            //self.profilePicImageView.sd_setImage(with: URL(string: picURL))
            self.profilePicImageView.sd_setImage(with: URL(string: picURL), completed: { (image, erros, cacheType, urls) in
                if (image != nil){
                    self.profilePicImageView.image = image
                    self.hideActivityIndicator()
                } else{
                    self.profilePicImageView.image = #imageLiteral(resourceName: "image_person")
                    self.hideActivityIndicator()
                }
            })
        } else {
            self.profilePicImageView.image = #imageLiteral(resourceName: "image_person")
            self.hideActivityIndicator()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let facebookLogin = UserDefaults.standard.bool(forKey: "facebookLogin")
        let googleLogin = UserDefaults.standard.bool(forKey: "googleLogin")
        let genericLogin = UserDefaults.standard.bool(forKey: "genericLogin")
        UserDefaults.standard.set(false, forKey: "joiningAgreement")
        self.appDelegate.userAgreement = false
        
        if(facebookLogin){
            print("====> facebook logout")
            UserDefaults.standard.set(false, forKey: "facebookLogin")
            self.loginManager.logOut()
        } else if(googleLogin){
            print("====> google logout")
            UserDefaults.standard.set(false, forKey: "googleLogin")
            GIDSignIn.sharedInstance().signOut()
        } else if(genericLogin){
            print("====> generic logout")
            UserDefaults.standard.set(false, forKey: "genericLogin")
        }
        self.appDelegate.logged = false
        UserDefaults.standard.set(false, forKey: "logged")
        self.appDelegate.loginHandler()
    }
    
    @IBAction func rateUsButtonPressed(_ sender: Any) {
        self.displayAlertWithYesAndNo(alertMessage: "Do you like what you see on Pikanite ?")
    }
    
    @IBAction func myWalletButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "MyWalletViewController")
    }
    
    @IBAction func supportButtonPressed(_ sender: Any) {
        
        sendEmail()
    }
    
    @IBAction func faqButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "FAQViewController")
    }
    
    @IBAction func aboutButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "AboutViewController")
    }
    
    @IBAction func inviteFriendsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "InviteFriendsViewController")
    }
    
    @IBAction func notificationButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "NotificationSettingsViewController")
    }
    
    @IBAction func howToPikaniteButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "UserGuideViewController")
    }
    
    @IBAction func editProfileDetailsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "ProfileViewController")
    }
    
    @IBAction func profilePictureButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@pikanite.com"])
            mail.setMessageBody("<p>Hi, I'm \(name),  <br /><br /><: type your message here! write to us... :> </p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
  

    
    func updateProfilePicture(imageData: UIImage) -> Bool {
        self.showActivityIndicator()
        UserHelper.changeProfilePic(imageData: imageData, email: UserDefaults.standard.string(forKey: "userEmail")!) { (isSuccess, response, errors) in
            
            if isSuccess && response != nil{
                self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "profile picture uploading success!")
                let url = RequestUrls.getProfileUrl
                UserDefaults.standard.set(url, forKey: "profileImageURL")
                self.performLoading()
                self.hideActivityIndicator()
            } else if errors != nil {
                if errors!.errors.count > 0 {
                    self.displayAlertWithOk(title: "Oppps!", alertMessage: "Pikanite Says!, some thing went wrong!")
                }
                self.hideActivityIndicator()
            }
        }
        
        return false
    }
    
    
}





extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        let resizedImage = resizeImage(image: img, newWidth: 300)
        let data  = UIImagePNGRepresentation(resizedImage) as Data?
        self.profilePicImageView.image = resizedImage
        self.updateProfilePicture(imageData: self.profilePicImageView.image!)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
