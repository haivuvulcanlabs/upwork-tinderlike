//
//  CoinPlan.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation
import StoreKit

// MARK: - CoinPlan
struct StoreConfig: Codable,Hashable {
    var title: String?
    var productID: String?
    var promoted: Bool
    var durationText: String
    var duration: Int
}


struct StoreItem {
    let config: StoreConfig
    let product: SKProduct
    
    var promoted: Bool {
        return config.promoted
    }
}
