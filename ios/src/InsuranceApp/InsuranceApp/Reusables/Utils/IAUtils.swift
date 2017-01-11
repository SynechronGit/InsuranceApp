//
//  IAUtils.swift
//  InsuranceApp
//
//  Created by rupendra on 6/9/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAUtils: NSObject {
    static func doesRegexMatch(_ pRegexPattern :String, subject pSubject :String) throws -> Bool {
        var aReturnVal :Bool = false
        
        let aRegularExpression = try NSRegularExpression(pattern: pRegexPattern, options: NSRegularExpression.Options.caseInsensitive)
        if aRegularExpression.firstMatch(in: pSubject, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, (pSubject.lengthOfBytes(using: String.Encoding.utf8)))) != nil {
            aReturnVal = true
        }
        
        return aReturnVal
    }
    
    static func convertStringtoInt(_ aIntString: String) -> Int {
        var convertedInt : Int = Int()
        if let myNumber = NumberFormatter().number(from: aIntString) {
             convertedInt = myNumber.intValue
        }
    return convertedInt
    }
    
    
    static func fixImageOrientation(_ src:UIImage)->UIImage {
        
        if src.imageOrientation == UIImageOrientation.up {
            return src
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch src.imageOrientation {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: src.size.width, y: src.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: src.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: src.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            break
        case UIImageOrientation.up, UIImageOrientation.upMirrored:
            break
        }
        
        switch src.imageOrientation {
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform.translatedBy(x: src.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform.translatedBy(x: src.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImageOrientation.up, UIImageOrientation.down, UIImageOrientation.left, UIImageOrientation.right:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: src.cgImage!.bitsPerComponent, bytesPerRow: 0, space: src.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch src.imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
            break
        default:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }

}
