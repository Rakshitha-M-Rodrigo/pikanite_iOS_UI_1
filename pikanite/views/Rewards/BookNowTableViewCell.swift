//
//  BookNowTableViewCell.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/19/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class BookNowTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    //MARK: variables
    var pressedAction : (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bookNowButtonPressed(_ sender: Any) {
        if let buttonAction = self.pressedAction
        {
            buttonAction()
        }
    }
    
}
