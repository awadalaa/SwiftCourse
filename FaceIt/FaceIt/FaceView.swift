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
    enum Eye {
        case Left
        case Right
    }
    
    private func pathForCicleCenteredAtPoint(midPoint: CGPoint, withRadius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: withRadius,
            startAngle: 0.0,
            endAngle: CGFloat(2 * M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0

        return path
    }
    
    func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }

        return eyeCenter
    }
    
    func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        return pathForCicleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
    }
    
    func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset

        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)

        return UIBezierPath(rect: mouthRect)
    }

    override func drawRect(rect: CGRect) {
        UIColor.blueColor().set()
        pathForCicleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
    }
}