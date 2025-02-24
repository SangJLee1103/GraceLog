//
//  UIColor+CustomColor.swift
//  GraceLog
//
//  Created by 이상준 on 12/28/24.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static var themeColor: UIColor {
        return UIColor(hex: 0xFE5F51)
    }
    
    static var graceGray: UIColor {
        return UIColor(hex: 0x414141)
    }
    
    static var graceLightGray: UIColor {
        return UIColor(hex: 0xD9D9D9)
    }
}
