//
//  StreakView.swift
//  GiveABO-3
//
//  Created by Sebastian Drew on 11/16/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

@IBDesignable class StreakView: UIView {
    
    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor(red:0.49, green:0.44, blue:0.82, alpha:0.3)
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 8
        
        let startAngle: CGFloat = 3 * π / 2
        let endAngle: CGFloat =  π / 3
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
    }
    
}