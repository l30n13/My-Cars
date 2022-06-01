//
//  UIFont+Extension.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import UIKit

extension UIFont {
    
    enum FontStyles: String {
        case bold = "Bold"
        case heavy = "Heavy"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    
    static func SFUIText(_ type: FontStyles = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "SFUIText-\(type.rawValue)", size: size)!
    }
}
