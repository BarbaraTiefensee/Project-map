//
//  UiColor + Extension.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 23/08/21.
//
import UIKit
import Foundation

extension UIColor {
    open class var blue74B3CE : UIColor {
        return UIColor(hex: "#74B3CE")
    }
    
    open class var blue508991 : UIColor {
        return UIColor(hex: "#508991")
    }
    
    open class var blue172A3A : UIColor {
        return UIColor(hex: "#172A3A")
    }
    
    open class var green004346 : UIColor {
        return UIColor(hex: "#004346")
    }
    
    open class var green09BC8A : UIColor {
        return UIColor(hex: "#09BC8A")
    }
    
    open class var black424848 : UIColor {
        return UIColor(hex: "#424848")
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
    
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: { mode in
                switch mode.userInterfaceStyle {
                case .dark:
                    return dark
                case .light:
                    return light
                default:
                    return light
                }
            })
        }
        return light
    }
}
