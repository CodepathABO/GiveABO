//
//  StoriesData.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import Foundation
import UIKit

class Story {
    
    var storyID = ""
    var name = ""
    var city = ""
    var state = ""
    var featureImage: UIImage?
    var summary = ""
    var userType: UIImage?
    
    init(storyID: String, name: String, city: String, state: String, featureImage: UIImage!, summary: String, userType: UIImage!) {
    
    self.storyID = storyID
    self.name = name
    self.city = city
    self.state = state
    self.featureImage = featureImage
    self.summary = summary
    self.userType = userType
    }
    
}
