//
//  Marker.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/28/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import Foundation
import UIKit

var priceText: String = ""
var currencyCode: String = ""

class Marker: UIView, UITextViewDelegate{
    override func awakeFromNib() {
        super.awakeFromNib()
        var labeltext: UILabel = viewWithTag(2) as! UILabel
        labeltext.text = "00.00 K"
        var labeltextlkr: UILabel = viewWithTag(1) as! UILabel
        labeltextlkr.text = "LKR"
        
    }
    
    public func assignText(string: String){
        var labeltext: UILabel = viewWithTag(2) as! UILabel
        labeltext.text = string
    }
}
