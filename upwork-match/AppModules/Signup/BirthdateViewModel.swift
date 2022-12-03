//
//  BirthdateViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

enum BirthdayField: Int, Hashable, CaseIterable {
    case day1 = 0, day2, month1, month2, year1, year2, year3, year4
    
    var playHolder: String {
        switch self {
        case .day1, .day2:
            return "D"
        case .month1,.month2:
            return "M"
        default:
            return "Y"
        }
    }
    
    var max: Int {
        switch self {
        case .day1:
            return 3
        case .month1:
            return 1
        case .year1:
            return 2
        default:
            return 9
        }
    }
}

class BirthdateViewModel: ObservableObject {
   
}
