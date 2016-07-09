//
//  FaceView.swift
//  FaceIt
//
//  Created by Alaa Awad on 7/9/16.
//  Copyright © 2016 Alaa Awad. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.9
    var skullRadius: CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    override func drawRect(rect: CGRect) {

        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        skull.lineWidth = 5.0
        UIColor.blueColor().set()
        skull.stroke()
    }
}