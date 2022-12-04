// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal static let icProfile1 = ImageAsset(name: "ic-profile-1")
    internal static let icThumb1 = ImageAsset(name: "ic-thumb-1")
    internal static let icThumb2 = ImageAsset(name: "ic-thumb-2")
    internal static let icThumb3 = ImageAsset(name: "ic-thumb-3")
    internal static let icThumb4 = ImageAsset(name: "ic-thumb-4")
    internal static let icThumb5 = ImageAsset(name: "ic-thumb-5")
    internal static let imProfileFull = ImageAsset(name: "im-profile-full")
    internal static let icBackRed = ImageAsset(name: "ic-back-red")
    internal static let icBigFillHeart = ImageAsset(name: "ic-big-fill-heart")
    internal static let icChatActive = ImageAsset(name: "ic-chat-active")
    internal static let icChat = ImageAsset(name: "ic-chat")
    internal static let icCloseRed = ImageAsset(name: "ic-close-red")
    internal static let icCloseWhite = ImageAsset(name: "ic-close-white")
    internal static let icDiscover = ImageAsset(name: "ic-discover")
    internal static let icDownArrow = ImageAsset(name: "ic-down-arrow")
    internal static let icDrawer = ImageAsset(name: "ic-drawer")
    internal static let icEditProfile = ImageAsset(name: "ic-edit-profile")
    internal static let icFilter = ImageAsset(name: "ic-filter")
    internal static let icHeart = ImageAsset(name: "ic-heart")
    internal static let icLogo = ImageAsset(name: "ic-logo")
    internal static let icPin = ImageAsset(name: "ic-pin")
    internal static let icPlus = ImageAsset(name: "ic-plus")
    internal static let icProfile = ImageAsset(name: "ic-profile")
    internal static let icRemove = ImageAsset(name: "ic-remove")
    internal static let icRightArrow = ImageAsset(name: "ic-right-arrow")
    internal static let icSearch = ImageAsset(name: "ic-search")
    internal static let icSetting = ImageAsset(name: "ic-setting")
    internal static let icShieldRed = ImageAsset(name: "ic-shield-red")
    internal static let icShield = ImageAsset(name: "ic-shield")
    internal static let icTrash = ImageAsset(name: "ic-trash")
  }
  internal enum Colors {
    internal static let hex0A84FF = ColorAsset(name: "hex0A84FF")
    internal static let hex252525 = ColorAsset(name: "hex252525")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  fileprivate let name: String

  internal var color: Color {
    Color(self)
  }
}

internal extension Color {
  /// Creates a named color.
  /// - Parameter asset: the color resource to lookup.
  init(_ asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(asset.name, bundle: bundle)
  }
}

internal struct ImageAsset {
  fileprivate let name: String

  internal var image: Image {
    Image(name)
  }
}

internal extension Image {
  /// Creates a labeled image that you can use as content for controls.
  /// - Parameter asset: the image resource to lookup.
  init(_ asset: ImageAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(asset.name, bundle: bundle)
  }
}

private final class BundleToken {}
