//
//  CountryManager.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import UIKit

public final class CountryManager {
    public static let shared = CountryManager()
    private init() {}

    // Default theme is support dark mode
    public var config: Configuration = Config()

    // For localization we use current locale by default but you can change localeIdentifier for specific cases
    public var localeIdentifier: String = NSLocale.current.identifier

    /// - Returns: Country array
    public func getCountries() -> [Country] {
        guard let path = Bundle.main.path(forResource: "countries", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return [] }
        return (try? JSONDecoder().decode([Country].self, from: data)) ?? []
    }
}
