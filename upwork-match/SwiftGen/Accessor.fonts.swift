// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

extension Font {
  public static func openSans(_ style: OpenSansStyle, fixedSize: CGFloat) -> Font {
    return Font.custom(style.rawValue, fixedSize: fixedSize)
  }

  public static func openSans(_ style: OpenSansStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
    return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
  }

  public enum OpenSansStyle: String {
    case bold = "OpenSans-Bold"
    case boldItalic = "OpenSans-BoldItalic"
    case extraBold = "OpenSans-ExtraBold"
    case extraBoldItalic = "OpenSans-ExtraBoldItalic"
    case italic = "OpenSans-Italic"
    case light = "OpenSans-Light"
    case lightItalic = "OpenSans-LightItalic"
    case medium = "OpenSans-Medium"
    case mediumItalic = "OpenSans-MediumItalic"
    case regular = "OpenSans-Regular"
    case semiBold = "OpenSans-SemiBold"
    case semiBoldItalic = "OpenSans-SemiBoldItalic"
  }
}

extension Font {
  public static func roboto(_ style: RobotoStyle, fixedSize: CGFloat) -> Font {
    return Font.custom(style.rawValue, fixedSize: fixedSize)
  }

  public static func roboto(_ style: RobotoStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
    return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
  }

  public enum RobotoStyle: String {
    case black = "Roboto-Black"
    case bold = "Roboto-Bold"
    case medium = "Roboto-Medium"
    case regular = "Roboto-Regular"
  }
}
