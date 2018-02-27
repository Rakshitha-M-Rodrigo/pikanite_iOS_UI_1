//
//  CardsTableViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/19/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class CardsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardExpireDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
