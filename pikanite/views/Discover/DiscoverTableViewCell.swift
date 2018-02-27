//
//  DiscoverTableViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 1/16/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var taxDetails: UILabel!
    @IBOutlet weak var additoinalInfo: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var previousPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.additoinalInfo.alpha = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
