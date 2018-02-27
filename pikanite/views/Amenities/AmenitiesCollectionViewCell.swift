//
//  AmenitiesCollectionViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/4/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class AmenitiesCollectionViewCell: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet weak var amenityImage: UIImageView!
    @IBOutlet weak var amenityNameLabel: UILabel!
    @IBOutlet weak var contentCellView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenHeight = UIScreen.main.bounds.size.height
        heightConstraint.constant = screenHeight
        
    }

}
