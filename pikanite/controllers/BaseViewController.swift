//
//  BaseViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/4/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn

class BaseViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginManager = LoginManager()
    var bulletSymbol = "\u{2022}"
    var window: UIWindow?
    var register = false
    
    //MARK: Properties
    lazy var preloaderView: PreLoaderView? = {
        let loaderView = PreLoaderView(frame: UIScreen.main.bounds)
        return loaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil){
            UserDefaults.standard.set(true, forKey: "googleLogin")
            
            
            print(user.userID)
            print(user.authentication.idToken)
            print(user.profile.name)
            print(user.profile.givenName)
            print(user.profile.familyName)
            print(user.profile.email)
            
            let fullNameArr = (user.profile.name)!.components(separatedBy: " ")
            let firstName    = fullNameArr[0]
            let name = user.profile.name
            let email = user.profile.email
            let userId = user.userID
            
            
            UserDefaults.standard.set(firstName, forKey: "profileName")
            UserDefaults.standard.set(name,forKey: "UserName")
            UserDefaults.standard.set(email,forKey: "userEmail")
            
            if (user.profile.hasImage)
            {
                let pic = user.profile.imageURL(withDimension: 300)
                print(pic!)
                UserDefaults.standard.set(String(describing: pic!), forKey: "profileImageURL")
            } else {
                //no profile image on google.
                UserDefaults.standard.set("", forKey: "profileImageURL")
            }
            if (checkUserEmail(email: email!)){
                self.registerNewSocialMediaUser(name: name!, email: email!, socialLoginId: userId!, userType: "google")
            }
            
        }
        
            
        
            
        }
    
    func getStrikeThoroughText(text: String) -> NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func getAmenitiesImage(amenityName: String) -> UIImage{
        var amenityImage = UIImage()
        
        switch amenityName {
        case "24-Hours Front Desk":
            amenityImage = UIImage(named: "amenities_24hFrontDesk")!
        case "Air Conditioning":
            amenityImage = UIImage(named: "amenities_airConditioner")!
        case "Bar":
            amenityImage = UIImage(named: "amenities_bar")!
        case "Hair/Beauty Salon":
            amenityImage = UIImage(named: "amenities_beautySalon")!
        case "Complimentary Breakfast":
            amenityImage = UIImage(named: "amenities_breakfast")!
        case "Business Center":
            amenityImage = UIImage(named: "amenities_businessCenter")!
        case "Cleaning Services":
            amenityImage = UIImage(named: "amenities_cleaningService")!
        case "Tea & Coffee Tray":
            amenityImage = UIImage(named: "amenities_coffee")!
        case "amenities_cupid":
            amenityImage = UIImage(named: "amenities_cupid")!
        case "Facilities for Disabled Guests":
            amenityImage = UIImage(named: "amenities_disableGuest")!
        case "Currency Exchange":
            amenityImage = UIImage(named: "amenities_exchange")!
        case "Spa & Fitness Center":
            amenityImage = UIImage(named: "amenities_fitnessCenter")!
        case "Souvenir/Gift Shop":
            amenityImage = UIImage(named: "amenities_giftShop")!
        case "amenities_love":
            amenityImage = UIImage(named: "amenities_love")!
        case "Mini Bar":
            amenityImage = UIImage(named: "amenities_miniBar")!
        case "Night Club":
            amenityImage = UIImage(named: "amenities_nightClub")!
        case "Parking":
            amenityImage = UIImage(named: "amenities_parking")!
        case "Restaurant":
            amenityImage = UIImage(named: "amenities_restuarant")!
        case "Rooftop Deck":
            amenityImage = UIImage(named: "amenities_roofDeck")!
        case "Rooftop Bar":
            amenityImage = UIImage(named: "amenities_roofTopBar")!
        case "Room Service":
            amenityImage = UIImage(named: "amenities_roomService")!
        case "Safe":
            amenityImage = UIImage(named: "amenities_safeBox")!
        case "Shared Lounge":
            amenityImage = UIImage(named: "amenities_sharedLounge")!
        case "Satellite TV":
            amenityImage = UIImage(named: "amenities_smartTv")!
        case "amenities_spa":
            amenityImage = UIImage(named: "amenities_spa")!
        case "Pool":
            amenityImage = UIImage(named: "amenities_swimmingPool")!
        case "Toiletries":
            amenityImage = UIImage(named: "amenities_toiletries")!
        case "Bottled Water":
            amenityImage = UIImage(named: "amenities_water")!
        case "Free Wifi":
            amenityImage = UIImage(named: "amenities_wifi")!
        default:
            amenityImage = #imageLiteral(resourceName: "amenities_24hFrontDesk")
        }
        return amenityImage
    }
   
//    func showActivityIndicator() {
//        DispatchQueue.main.async {
//            self.preloaderView?.removeFromSuperview()
//            if let window = UIApplication.shared.keyWindow {
//                if self.preloaderView != nil && window.subviews.contains(self.preloaderView!) {
//                    return
//                }
//                window.addSubview(self.preloaderView!)
//                self.preloaderView?.startAnimation()
//            }
//        }
//    }
//
//    func hideActivityIndicator() {
//
//        DispatchQueue.main.async {
//            self.preloaderView?.stopAnimation()
//        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            self.preloaderView?.removeFromSuperview()
//        }
//    }
    
    func pushViewControllerWithNavigationController(viewController: String) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        self.navigationController?.pushViewController((storyboard.instantiateViewController(withIdentifier: viewController)), animated: true)
        let rootViewController = self.storyboard?.instantiateViewController(withIdentifier: viewController) as! UIViewController
        let nv = UINavigationController()
        nv.pushViewController(rootViewController, animated: true)
        nv.navigationBar.isHidden = true
       self.present(nv, animated: true, completion: nil)
    }
    
    func pushViewController(viewController: String){
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: viewController))!, animated: true)
    }
    
//    func showAlert(title: String = "Urban Agent", message: String){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportScreenViewController") as! ReportScreenViewController
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(vc, animated: true, completion: nil)
//        vc.successImageView.alpha = 0
//        vc.errorAlertLabel.text = message
//        vc.alertLabel.alpha = 0
//        vc.view.backgroundColor = .clear
//    }
//
//
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    func displayAlert(alertMessage: String, title: String = "Alert"){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportScreenViewController") as! ReportScreenViewController
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(vc, animated: true, completion: nil)
//        vc.successImageView.alpha = 0
//        vc.errorAlertLabel.text = alertMessage
//        vc.alertLabel.alpha = 0
//        vc.view.backgroundColor = .clear
//    }
    func displayAlertWithOk(title: String = "Pikanite Alert!", alertMessage: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OkPromptViewController") as! OkPromptViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.titleMessage = title
        vc.errorMessage = alertMessage
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func passwordPrompt(userEmail: String, HotelEmail: String, RoomCount: String, recordedDate: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordPromptViewController") as! PasswordPromptViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.userEmail = userEmail
        vc.hotelEmail = HotelEmail
        vc.roomCount = RoomCount
        vc.recordedDate = recordedDate
        self.present(vc, animated: true, completion: nil)
    }
    
    func displayAlertWithYesAndNo(alertMessage: String, title: String = "Alert"){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YesNoPromptViewController") as! YesNoPromptViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func promptJoiningAgreement(logginType: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgreementViewController") as! AgreementViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.logginType = logginType
        self.present(vc, animated: true, completion: nil)
    }
    
    func promptBookingStatus(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingStatusViewController") as! BookingStatusViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.preloaderView?.removeFromSuperview()
            if let window = UIApplication.shared.keyWindow {
                if self.preloaderView != nil && window.subviews.contains(self.preloaderView!) {
                    return
                }
                window.addSubview(self.preloaderView!)
                self.preloaderView?.startAnimation()
            }
        }
    }
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.preloaderView?.stopAnimation()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.preloaderView?.removeFromSuperview()
        }
    }
    
    
    func hotelProfileButtonPressed() {
        let destinationViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "HotelProfileViewController") as! HotelProfileViewController
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        destinationViewController.navigationController?.navigationBar.isHidden = true
        self.present(navigationController, animated: true)
    }

    
    func registerNewUser(name: String, email: String, password: String){
        self.showActivityIndicator()
        UserHelper.registerNewUser(email: email, name: name, password: password) { (success, response, errors) in
            if (errors == nil){
                print(response!.dictionaryObject!)
                let result = response!.dictionaryObject!
                if ((result["message"]! as! String) == "success"){
                    self.displayAlertWithOk(title: "Congratulations from Pikanite!", alertMessage: "You have been successfully registered!")
                    let Userdata = result["content"]! as! [String: Any]
                    print(Userdata)
                    let name = Userdata["name"] as! String
                    let userEmail = Userdata["email"] as! String
                    let userProfilePic = Userdata["userProfilePic"] as! String
                    let contactNumber = Userdata["contactNumber"] as! String
                    let id = Userdata["_id"] as! String
                    let birthDay = Userdata["birthDay"] as! String
                    let socialID = Userdata["socialLoginId"] as! String
                    
                    self.addUserData(userName: name, userEmail: userEmail, userProfilePic: userProfilePic, userContactNumber: contactNumber, userID: id, userBirthDay: birthDay, userSocialLoginID: socialID)
                    UserDefaults.standard.set(true, forKey: "logged")
                    self.appDelegate.logged = true
                    self.appDelegate.loginHandler()
                    self.hideActivityIndicator()
                }
            } else {
                self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says, Some thing went wrong!")
                self.hideActivityIndicator()
            }
        }
    }
    
    func registerNewSocialMediaUser(name: String, email: String, socialLoginId: String, userType: String){
        self.showActivityIndicator()
        UserHelper.loginSocialMediaUser(email: email, name: name, socialLoginId: socialLoginId, userType: userType) { (success, response, errors) in
            if (errors == nil){
                print(response!.dictionaryObject!)
                let result = response!.dictionaryObject!
                if ((result["message"]! as! String) == "success"){
                    self.displayAlertWithOk(title: "Congratulations from Pikanite!", alertMessage: "You have been successfully registered!")
                    print(result)
                   // let data = result["content"]! as! [String:Any]
                    var name: String = ""
                    var userEmail: String = ""
                    var userProfilePic: String = ""
                    var contactNumber: String = ""
                    var id: String = ""
                    var birthDay: String = ""
                    var socialID: String = ""
                    
                    if (result["content"] != nil){
                        let data = result["content"]! as! [String:Any]
                        name = data["name"] as! String
                        userEmail = data["email"] as! String
                        userProfilePic = data["userProfilePic"] as! String
                        contactNumber = data["contactNumber"] as! String
                        id = data["userId"] as! String
                        birthDay = data["birthDay"] as! String
                        socialID = data["socialLoginId"] as! String
                    } else {
                        name = result["name"] as! String
                        userEmail = result["email"] as! String
                        userProfilePic = result["userProfilePic"] as! String
                        contactNumber = result["contactNumber"] as! String
                        id = result["userId"] as! String
                        birthDay = result["birthDay"] as! String
                        socialID = result["socialLoginId"] as! String
                    }
                    
                    self.addUserData(userName: name, userEmail: userEmail, userProfilePic: userProfilePic, userContactNumber: contactNumber, userID: id, userBirthDay: birthDay, userSocialLoginID: socialID)
                    UserDefaults.standard.set(true, forKey: "logged")
                    self.appDelegate.logged = true
                    self.appDelegate.loginHandler()
                    self.hideActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "loggin error... contact pikanite administration")
                }
            } else {
                self.displayAlertWithOk(title: "Oops!", alertMessage: "Pikanite says, Some thing went wrong!")
                self.hideActivityIndicator()
            }
        }
        
    }
    
    func addUserData(userName: String, userEmail: String, userProfilePic: String, userContactNumber: String, userID: String, userBirthDay: String, userSocialLoginID: String){
        UserDefaults.standard.set(userName, forKey: "UserName")
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userProfilePic, forKey: "profileImageURL")
        UserDefaults.standard.set(userContactNumber, forKey: "userContactNumber")
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.set(userBirthDay, forKey: "userBirthDay")
        UserDefaults.standard.set(userSocialLoginID, forKey: "userSocialLoginID")
        
        let name = UserDefaults.standard.string(forKey: "UserName")!
        let fullNameArr = name.components(separatedBy: " ")
        let firstName    = fullNameArr[0]
        UserDefaults.standard.set(firstName,forKey: "profileName")
        
        self.setProfileData()
        
        
    }
    
    func setProfileData(){
        appDelegate.userProfile.name = UserDefaults.standard.string(forKey: "UserName")!
        appDelegate.userProfile.email = UserDefaults.standard.string(forKey: "userEmail")!
        appDelegate.userProfile.userProfilePic = UserDefaults.standard.string(forKey: "profileImageURL")!
        appDelegate.userProfile.contactNumber = UserDefaults.standard.string(forKey: "userContactNumber")!
        appDelegate.userProfile.id = UserDefaults.standard.string(forKey: "userID")!
        appDelegate.userProfile.birthDay = UserDefaults.standard.string(forKey: "userBirthDay")!
        appDelegate.userProfile.socialLoginId = UserDefaults.standard.string(forKey: "userSocialLoginID")!
        appDelegate.userProfile.userFirstName = UserDefaults.standard.string(forKey: "profileName")!
    }
    
    func checkUserEmail(email: String) -> Bool {
        UserHelper.checkUser(email: email){ (success, resposnse, errors) in
            if (errors == nil){
                let status = (resposnse!.dictionaryObject)!["message"]! as! String
                
                if (status == "failed"){
                    print("===> user does not exist")
                    self.register = true
                } else if (status == "success"){
                    self.register = false
                    let content = (resposnse!.dictionaryObject)!["content"]! as! [String: Any]
                    print("===> user exist")
                    print(content["name"] as! String)
                    let name = content["name"] as! String
                    let userEmail = content["email"] as! String
                    let userProfilePic = content["userProfilePic"] as! String
                    let contactNumber = content["contactNumber"] as! String
                    let id = content["_id"] as! String
                    let birthDay = content["birthDay"] as! String
                    let socialID = content["socialLoginId"] as! String
                    self.addUserData(userName: name, userEmail: userEmail, userProfilePic: userProfilePic, userContactNumber: contactNumber, userID: id, userBirthDay: birthDay, userSocialLoginID: socialID)
                    UserDefaults.standard.set(true, forKey: "logged")
                    self.appDelegate.logged = true
                    self.dismiss(animated: true, completion: nil)
                    self.appDelegate.loginHandler()
                }
            }
        }
        return self.register
    }
    
    func bookHotelNow(userEmail: String, HotelEmail: String, RoomCount: String, PromoCode: String = "nan"){
        self.showActivityIndicator()
        let recordedDate = self.getCurrentDateTime()
        UserHelper.bookHotel(userEmail: userEmail, HotelEmail: HotelEmail, RoomCount: RoomCount, recordedDate: recordedDate, promoCode: PromoCode ) { (success, response, errors) in
            if (errors == nil){
                self.hideActivityIndicator()
                print(response as Any)
                let data = response!.dictionaryObject!
                if((data["message"] as! String) == "success"){
                    self.promptBookingStatus()
                } else {
                    self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Sorry, couldn't place the booking, please contact us...")
                }
            } else {
                self.displayAlertWithOk(title: "Pikanite Says!", alertMessage: "Some thing went wrong...!")
                self.hideActivityIndicator()
            }
        }
        self.hideActivityIndicator()
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func isBetweenMyTwoDates(date: NSDate, startDateString:String , endDateString: String) -> Bool {
        let dateMaker = DateFormatter()
        dateMaker.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let start = dateMaker.date(from: startDateString)!
        let end = dateMaker.date(from: endDateString)!

        
        if start.compare(date as Date) == .orderedAscending && end.compare(date as Date) == .orderedDescending {
            print("########===> within range")
            return true
        }
        print("########===> not within range")
        return false
    }

    func getCurrentTime()->String{
        let date = NSDate()
        let aStrDate = String(describing: date)//"2014-09-20 04:45:20 +0000"
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let aDate: Date? = aDateFormatter.date(from: aStrDate)
        aDateFormatter.dateFormat = "HH:mm:ss"
        if let aDate = aDate {
            print("\(aDateFormatter.string(from: aDate))")
        }
        return ("\(aDateFormatter.string(from: aDate!))")
    }
    
    func getCurrentDateTime()->String{
        let date = NSDate()
        let aStrDate = String(describing: date)//"2014-09-20 04:45:20 +0000"
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let aDate: Date? = aDateFormatter.date(from: aStrDate)
        aDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let aDate = aDate {
            print("\(aDateFormatter.string(from: aDate))")
        }
        return ("\(aDateFormatter.string(from: aDate!))")
    }
    
    
    func extractTimefromDateString(string: String)->String{
        //        let date = NSDate()
        let aStrDate = String(describing: string)//"2014-09-20 04:45:20 +0000"
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let aDate: Date? = aDateFormatter.date(from: aStrDate)
        aDateFormatter.dateFormat = "HH:mm:ss"
        if let aDate = aDate {
            print("\(aDateFormatter.string(from: aDate))")
        }
        return ("\(aDateFormatter.string(from: aDate!))")
    }
    
    func getShrotDateTime(string: String)->String{
//        let date = NSDate()
        let aStrDate = String(describing: string)//"2014-09-20 04:45:20 +0000"
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let aDate: Date? = aDateFormatter.date(from: aStrDate)
        aDateFormatter.dateFormat = "E, dd MMM"
        if let aDate = aDate {
            print("\(aDateFormatter.string(from: aDate))")
        }
        return ("\(aDateFormatter.string(from: aDate!))")
    }
    
    func getTimeOn_HH_MM_Format(string: String) -> String{
        
        let fullTime = string.components(separatedBy: ":")
        let HH = fullTime[0]
        let MM = fullTime[1]
        let SS = fullTime[2]
        return "\(HH):\(MM)"
    }
    
    func getTimeOn_HH_MM_Array(string: String) -> [String:Any]{
        
        let fullTime = string.components(separatedBy: ":")
        let HH = fullTime[0]
        let MM = fullTime[1]
        let SS = fullTime[2]
        return ["HH":Int(HH)!, "MM":Int(MM)!, "SS":Int(SS)!]
    }
    
    
    func convertNextDate(dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let nextDate = dateFormatter.string(from: tomorrow!)
        let formattedDate = self.ISOStringFromDate(date: tomorrow!)
        print("your next Date is \(formattedDate)")
        return formattedDate
    }
    
    func getShrotDateTimeWithYear(string: String)->String{
        //        let date = NSDate()
        let aStrDate = String(describing: string)//"2014-09-20 04:45:20 +0000"
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let aDate: Date? = aDateFormatter.date(from: aStrDate)
        aDateFormatter.dateFormat = "E, dd MMM yyyy"
        if let aDate = aDate {
            print("\(aDateFormatter.string(from: aDate))")
        }
        
        return ("\(aDateFormatter.string(from: aDate!))")
    }
    
    func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func shortDateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "E,dd MMM"
        print(dateFormatter.date(from: string) as! Any)
        return dateFormatter.date(from: string)
    }
    
    func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }

}

extension Date {
    static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
}
