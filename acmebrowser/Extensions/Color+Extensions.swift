//
//  Color+Extensions.swift
//  acmebrowser
//
//  Created by Victor Idongesit on 13/04/2022.
//

import SwiftUI

enum ACMEColor: String {
    case borders = "#E6E6E6"
    case textFieldBackground = "#F0F0F0"
    case textColor = "#9A9A9A"
    case progressView = "#0037C3"
    case progressViewBackground = "#E5E5E5"
    case appBackground = "#FFFFFF"
    case navButton = "#737373"
}

extension UIColor {
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

extension Color {
    static func from(_ acmeColor: ACMEColor) -> Color {
        return Color(UIColor(acmeColor.rawValue))
    }
}
