//
//  PastBookingTableViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/10/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class PastBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    
    var url = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hotelImageView.sd_setImage(with: URL(string: url))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
