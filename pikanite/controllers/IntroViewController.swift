//
//  IntroViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/7/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var hiLableCenter: CGPoint!
        
        //animation
        self.hiImageView.alpha = 0
        self.hiLabel.alpha = 0
        self.hiDescriptionLabel.alpha = 0
        self.introControllerView.alpha = 0
        self.hiLabel.font.withSize(1)
        hiLableCenter = self.hiLabel.center
        self.hiLabel.center = self.mainContainerView.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.hiLabel.alpha = 1
                self.hiLabel.font.withSize(40)
            }, completion: nil)
            UIView.animate(withDuration: 3,delay: 1, animations: {
                self.hiLabel.center = hiLableCenter
            })
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

extension IntroViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let percentage = (offset.x / (self.scrollView.frame.size.width  * 2) ) * 100
        print(percentage)
        
    }
}