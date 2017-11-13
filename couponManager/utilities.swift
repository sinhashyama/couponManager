//
//  utilities.swift
//  couponManager
//
//  Created by Singh, Abhay on 7/2/17.
//  Copyright © 2017 SHC. All rights reserved.
//

import UIKit

class utilities: NSObject {

    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame:CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    class func superScript(_ textToWrite:String, locationInt:Int, length:Int, font1:UIFont, font2:UIFont) -> NSAttributedString{
        let font:UIFont? = font1
        let fontSuper:UIFont? = font2
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: textToWrite, attributes: [NSFontAttributeName:font!])
        attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:10], range: NSRange(location:locationInt,length:length))
        return attString;
    }
    
    

}

extension String {
    func index(of target: String) -> Int? {
        if let range = self.range(of: target) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    func lastIndex(of target: String) -> Int? {
        if let range = self.range(of: target, options: .backwards) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
}
