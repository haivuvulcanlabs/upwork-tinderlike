//
//  Configuration.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import UIKit

public protocol Configuration {
    var countryNameTextColor: UIColor { get set }
    var countryNameTextFont: UIFont { get set }
    var selectedCountryCodeBackgroundColor: UIColor { get set }
    var selectedCountryCodeTextColor: UIColor { get set }
    var selectedCountryCodeCornerRadius: CGFloat { get set }
    var countryCodeFont: UIFont { get set }
    var countryCodeTextColor: UIColor { get set }
    var closeButtonTextColor: UIColor { get set }
    var closeButtonFont: UIFont { get set }
    var closeButtonText: String { get set }
    var titleTextColor: UIColor { get set }
    var titleFont: UIFont { get set }
    var titleText: String { get set }
    var searchBarPlaceholder: String { get set }
    var searchBarBackgroundColor: UIColor { get set }
    var searchBarPlaceholderColor: UIColor { get set }
    var searchBarFont: UIFont { get set }
    var searchBarLeftImage: UIImage? { get set }
    var searchBarClearImage: UIImage? { get set }
    var searchBarCornerRadius: CGFloat { get set }
    var separatorColor: UIColor { get set }
}

public struct Config: Configuration {
    
    /// textColor of countryNameLabel
    public var countryNameTextColor: UIColor
    
    /// font of countryNameLabel
    public var countryNameTextFont: UIFont
    
    /// background color of countryCodeLabel's selected state
    public var selectedCountryCodeBackgroundColor: UIColor
    
    /// textColor of countryCodeLabel's selected state
    public var selectedCountryCodeTextColor: UIColor
    
    /// corner radius of countryCodeLabel's selected state
    public var selectedCountryCodeCornerRadius: CGFloat
    
    /// font of countryCodeLabel
    public var countryCodeFont: UIFont
    
    /// textColor of countryCodeLabel
    public var countryCodeTextColor: UIColor
    
    /// textColor of closeButton
    public var closeButtonTextColor: UIColor
    
    /// font of closeButton
    public var closeButtonFont: UIFont
    
    // text of closeButton
    public var closeButtonText: String
    
    /// textColor of titleLabel
    public var titleTextColor: UIColor
    
    /// font of titleLabel
    public var titleFont: UIFont

    /// text of titleLabel
    public var titleText: String

    /// placeholder text of searchTextField
    public var searchBarPlaceholder: String
    
    /// background color  of searchTextField
    public var searchBarBackgroundColor: UIColor
    
    /// placeholder text color of searchTextField
    public var searchBarPlaceholderColor: UIColor
    
    /// font of searchTextField
    public var searchBarFont: UIFont
    
    /// left image of searchTextField
    public var searchBarLeftImage: UIImage?
    
    /// clear image of searchTextField
    public var searchBarClearImage: UIImage?
    
    /// corner radius of searchTextField
    public var searchBarCornerRadius: CGFloat
    
    /// background color of separatorView
    public var separatorColor: UIColor

    public init(
        countryNameTextColor: UIColor = ColorCompatibility.label,
        countryNameTextFont: UIFont = UIFont.systemFont(ofSize: 16),
        selectedCountryCodeBackgroundColor: UIColor = .systemGreen,
        selectedCountryCodeTextColor: UIColor = ColorCompatibility.systemBackground,
        selectedCountryCodeCornerRadius: CGFloat = 8,
        countryCodeFont: UIFont = UIFont.systemFont(ofSize: 16),
        countryCodeTextColor: UIColor = ColorCompatibility.systemGray2,
        closeButtonTextColor: UIColor = .systemGreen,
        closeButtonFont: UIFont = UIFont.systemFont(ofSize: 16),
        closeButtonText: String = "Close",
        titleTextColor: UIColor = ColorCompatibility.label,
        titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18),
        titleText: String = "Select Country",
        searchBarPlaceholder: String = "Search...",
        searchBarBackgroundColor: UIColor = ColorCompatibility.systemGray5,
        searchBarPlaceholderColor: UIColor = ColorCompatibility.systemGray2,
        searchBarFont: UIFont = UIFont.systemFont(ofSize: 16),
        searchBarLeftImage: UIImage? = nil,
        searchBarClearImage: UIImage? = nil,
        searchBarCornerRadius: CGFloat = 4,
        separatorColor: UIColor = ColorCompatibility.systemGray5
    ) {
        self.countryNameTextColor = countryNameTextColor
        self.countryNameTextFont = countryNameTextFont
        self.selectedCountryCodeBackgroundColor = selectedCountryCodeBackgroundColor
        self.selectedCountryCodeTextColor = selectedCountryCodeTextColor
        self.countryCodeFont = countryCodeFont
        self.countryCodeTextColor = countryCodeTextColor
        self.selectedCountryCodeCornerRadius = selectedCountryCodeCornerRadius
        self.closeButtonTextColor = closeButtonTextColor
        self.closeButtonFont = closeButtonFont
        self.closeButtonText = closeButtonText
        self.titleTextColor = titleTextColor
        self.titleFont = titleFont
        self.titleText = titleText
        self.searchBarPlaceholder = searchBarPlaceholder
        self.searchBarBackgroundColor = searchBarBackgroundColor
        self.searchBarPlaceholderColor = searchBarPlaceholderColor
        self.searchBarFont = searchBarFont
        self.searchBarLeftImage = searchBarLeftImage
        self.searchBarClearImage = searchBarClearImage
        self.searchBarCornerRadius = searchBarCornerRadius
        self.separatorColor = separatorColor
    }
}


public class ColorCompatibility: NSObject {
    public static var label: UIColor {
        if #available(iOS 13, *) {
            return .label
        }
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    public static var secondaryLabel: UIColor {
        if #available(iOS 13, *) {
            return .secondaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.6)
    }
    
    public static var tertiaryLabel: UIColor {
        if #available(iOS 13, *) {
            return .tertiaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
    }
    
    public static var quaternaryLabel: UIColor {
        if #available(iOS 13, *) {
            return .quaternaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.18)
    }
    
    public static var systemFill: UIColor {
        if #available(iOS 13, *) {
            return .systemFill
        }
        return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.2)
    }
    
    public static var secondarySystemFill: UIColor {
        if #available(iOS 13, *) {
            return .secondarySystemFill
        }
        return UIColor(red: 0.47058823529411764, green: 0.47058823529411764, blue: 0.5019607843137255, alpha: 0.16)
    }
    
    public static var tertiarySystemFill: UIColor {
        if #available(iOS 13, *) {
            return .tertiarySystemFill
        }
        return UIColor(red: 0.4627450980392157, green: 0.4627450980392157, blue: 0.5019607843137255, alpha: 0.12)
    }
    
    public static var quaternarySystemFill: UIColor {
        if #available(iOS 13, *) {
            return .quaternarySystemFill
        }
        return UIColor(red: 0.4549019607843137, green: 0.4549019607843137, blue: 0.5019607843137255, alpha: 0.08)
    }
    
    public static var placeholderText: UIColor {
        if #available(iOS 13, *) {
            return .placeholderText
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.3)
    }
    
    public static var systemBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        }
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    public static var secondarySystemBackground: UIColor {
        if #available(iOS 13, *) {
            return .secondarySystemBackground
        }
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    
    public static var tertiarySystemBackground: UIColor {
        if #available(iOS 13, *) {
            return .tertiarySystemBackground
        }
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    public static var systemGroupedBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemGroupedBackground
        }
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
    
    public static var secondarySystemGroupedBackground: UIColor {
        if #available(iOS 13, *) {
            return .secondarySystemGroupedBackground
        }
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    public static var tertiarySystemGroupedBackground: UIColor {
        if #available(iOS 13, *) {
            return .tertiarySystemGroupedBackground
        }
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }

    public static var separator: UIColor {
        if #available(iOS 13, *) {
            return .separator
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.29)
    }
    
    public static var opaqueSeparator: UIColor {
        if #available(iOS 13, *) {
            return .opaqueSeparator
        }
        return UIColor(red: 0.7764705882352941, green: 0.7764705882352941, blue: 0.7843137254901961, alpha: 1.0)
    }
    
    public static var link: UIColor {
        if #available(iOS 13, *) {
            return .link
        }
        return UIColor(red: 0.0, green: 0.47843137254901963, blue: 1.0, alpha: 1.0)
    }
    
    public static var systemIndigo: UIColor {
        if #available(iOS 13, *) {
            return .systemIndigo
        }
        return UIColor(red: 0.34509803921568627, green: 0.33725490196078434, blue: 0.8392156862745098, alpha: 1.0)
    }
    
    public static var systemGray2: UIColor {
        if #available(iOS 13, *) {
            return .systemGray2
        }
        return UIColor(red: 0.6823529411764706, green: 0.6823529411764706, blue: 0.6980392156862745, alpha: 1.0)
    }
    
    public static var systemGray3: UIColor {
        if #available(iOS 13, *) {
            return .systemGray3
        }
        return UIColor(red: 0.7803921568627451, green: 0.7803921568627451, blue: 0.8, alpha: 1.0)
    }
    
    public static var systemGray4: UIColor {
        if #available(iOS 13, *) {
            return .systemGray4
        }
        return UIColor(red: 0.8196078431372549, green: 0.8196078431372549, blue: 0.8392156862745098, alpha: 1.0)
    }
    
    public static var systemGray5: UIColor {
        if #available(iOS 13, *) {
            return .systemGray5
        }
        return UIColor(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.9176470588235294, alpha: 1.0)
    }
    
    public static var systemGray6: UIColor {
        if #available(iOS 13, *) {
            return .systemGray6
        }
        return UIColor(red: 0.9490196078431372, green: 0.9490196078431372, blue: 0.9686274509803922, alpha: 1.0)
    }
}
