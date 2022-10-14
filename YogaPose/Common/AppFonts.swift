//
//  AppFonts.swift
//  YogaPose
//
//  Created by Harsh on 30/09/22.
//

import UIKit

enum FontName: String {
    case DMSansBold = "DMSans-Bold"
    case DMSansRegular = "DMSans-Regular"
    case DMSansMedium = "DMSans-Medium"
}

extension UIFont {

    class func custom(name:FontName = FontName.DMSansRegular, size : CGFloat = 18.0) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size){
            return font
        }
        print("Font Not Found -> \(name.rawValue)")
        return UIFont.systemFont(ofSize: size)
    }
}

