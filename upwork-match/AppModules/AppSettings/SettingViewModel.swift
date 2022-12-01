//
//  SettingViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    static let shared = SettingViewModel()
    let items: [AppSettingGroup] = AppSettingGroup.allCases
}
