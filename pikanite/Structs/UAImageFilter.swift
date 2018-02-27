//
//  UAImageFilter.swift
//  tabbarconverted
//
//  Created by Gayanath Damith Amarasinghe on 12/11/17.
//  Copyright © 2017 Sachithra Udayanga. All rights reserved.
//

import Foundation
import UIKit

struct UAImageFilter {
    var filterName: String!
    var displayName: String!
    var filteredThumbnail: UIImage!
    
    init(filterName: String, displayName: String) {
        self.filterName = filterName
        self.displayName = displayName
    }
    
    mutating func setThumbnail(thumb: UIImage) {
        self.filteredThumbnail = thumb
    }
}
