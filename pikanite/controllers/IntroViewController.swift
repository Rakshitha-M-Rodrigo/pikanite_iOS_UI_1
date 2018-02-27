//
//  IntroViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/7/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController, UIGestureRecognizerDelegate {

    //MARK: outlets
    @IBOutlet weak var hiImageView: UIImageView!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var hiDescriptionLabel: UILabel!
    
    @IBOutlet weak var discoverImageView: UIImageView!
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var discoverDescriptionLabel: UILabel!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    @IBOutlet weak var introControllerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainContainerView: UIView!
    
    @IBOutlet weak var Dot1: UIView!
    @IBOutlet weak var Dot2: UIView!
    @IBOutlet weak var Dot3: UIView!
    
    @IBOutlet weak var introView_3: UIView!
    
    var hiLableCenter: CGPoint!
    var currentScrollRect = 0
    var currentScrollRectValue = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //animation
        self.hiImageView.alpha = 0
        self.hiLabel.alpha = 0
        self.hiDescriptionLabel.alpha = 0
        self.introControllerView.alpha = 0
        self.hiLabel.font.withSize(1)
        self.hiLabel.layer.setAffineTransform(CGAffineTransform(scaleX: 0.9, y: 0.9))
        
        self.Dot1.backgroundColor = UIColor.white
        self.Dot2.backgroundColor = UIColor.black
        self.Dot3.backgroundColor = UIColor.black
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

            UIView.animate(withDuration: 1.75, delay: 0, options: .curveEaseIn, animations: {
                self.hiLabel.alpha = 1
                self.hiLabel.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            }, completion: nil)
         
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                UIView.animate(withDuration: 2, animations: {
                    self.hiDescriptionLabel.alpha = 1
                })
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.hiImageView.alpha = 1
                })
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.introControllerView.alpha = 1
                    })
            })
        })
   
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            if(currentScrollRect==2){
                self.pushViewControllerWithNavigationController(viewController: "LoginViewController")
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.currentScrollRectValue = self.currentScrollRect+1
        self.scrollView.scrollRectToVisible(CGRect(x:self.view.frame.size.width * CGFloat(currentScrollRectValue), y:0, width:self.view.frame.width, height: self.view.frame.height), animated: true)
        if(currentScrollRect==2){
            self.pushViewControllerWithNavigationController(viewController: "LoginViewController")
        }
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        self.pushViewControllerWithNavigationController(viewController: "LoginViewController")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

extension IntroViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let percentage = (offset.x / (self.scrollView.frame.size.width  * 2) ) * 100
        print(percentage)
        
        if (percentage>=0 && percentage<=33){
            UIView.animate(withDuration: 0.3, animations: {
                self.Dot1.backgroundColor = UIColor.white
                self.Dot2.backgroundColor = UIColor.black
                self.Dot3.backgroundColor = UIColor.black
                self.currentScrollRect = 0
                
                
            })
        }
        if (percentage>=34 && percentage<=66){
            UIView.animate(withDuration: 0.3, animations: {
                self.Dot1.backgroundColor = UIColor.black
                self.Dot2.backgroundColor = UIColor.white
                self.Dot3.backgroundColor = UIColor.black
                self.currentScrollRect = 1
                
            })
        }
        if (percentage>=67 && percentage<=100){
            UIView.animate(withDuration: 0.3, animations: {
                self.Dot1.backgroundColor = UIColor.black
                self.Dot2.backgroundColor = UIColor.black
                self.Dot3.backgroundColor = UIColor.white
                self.currentScrollRect = 2
                
            })
        }
        
    }
}
