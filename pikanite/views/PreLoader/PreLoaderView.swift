//
//  PreLoaderView.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/18/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class PreLoaderView: UIView {

    //MARK: Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    //MARK: Variables
    var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = Bundle.main.loadNibNamed("PreLoaderView", owner: self, options: [:])?.first as! PreLoaderView
        view.frame = frame
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimation() {
        
        if isAnimating {
            return
        }
        
        isAnimating = true
      
        
            
        
        self.logoImageView.rotate()
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.backgroundView.alpha = 0.8
                        
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.2, animations: {
                            self.backgroundView.alpha = 1
                        }, completion: { (comp) in
                            
                        })
        })
    }
    
    func stopAnimation() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
            //self.logoImageView.stopAnimating()
            self.logoImageView.image = nil
            self.isAnimating = false
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.logoImageView.alpha = 0
        }) { (comp) in
            UIView.animate(withDuration: 0.4, animations: {
                self.backgroundView.alpha = 0
            }) { (comp) in
                
            }
        }
    }

}

extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
