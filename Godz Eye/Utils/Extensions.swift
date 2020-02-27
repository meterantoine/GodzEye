//
//  Extensions.swift
//  Godz Eye
//
//  Created by Antoine Perry on 2/25/20.
//  Copyright © 2020 Antoine Perry. All rights reserved.
//

import UIKit

extension UIImage {
    func fixedImageOrientation() -> UIImage {
        let imageUp = UIImage.Orientation.up
        let imageUpMirrored = UIImage.Orientation.upMirrored
        
        let imageRight = UIImage.Orientation.right
        let imageRightMirrored = UIImage.Orientation.rightMirrored
        
        let imageDown = UIImage.Orientation.down
        let imageDownMirrored = UIImage.Orientation.downMirrored
        
        let imageLeft = UIImage.Orientation.left
        let imageLeftMirrored = UIImage.Orientation.leftMirrored
        
        if imageOrientation == imageUp {
            return self
        }
        
        //Calculates if the proper transfromation to make the image upright
        //2 Steps: Rotate if Left/Right/Down, and then flip it Mirrored
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if imageOrientation == imageDown || imageOrientation == imageDownMirrored {
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        }
        
        if imageOrientation == imageLeft || imageOrientation == imageLeftMirrored {
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi/2)
        }
        
        if imageOrientation == imageRight || imageOrientation == imageRightMirrored {
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi/2)
        }
        
        if imageOrientation == imageUpMirrored || imageOrientation == imageDownMirrored {
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if imageOrientation == imageLeftMirrored || imageOrientation == imageRightMirrored {
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.translatedBy(x: -1, y: 1)
        }
        
        //Draw the underlying CGImage into a new context, applying the transform
        //calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        
        ctx.concatenate(transform)
        
        if (imageOrientation == imageLeft || imageOrientation == imageLeftMirrored || imageOrientation == imageRight || imageOrientation == imageRightMirrored) {
            
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        } else {
            ctx.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        //create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let imgEnd: UIImage = UIImage(cgImage: cgimg)
        
        return imgEnd
    }
}

