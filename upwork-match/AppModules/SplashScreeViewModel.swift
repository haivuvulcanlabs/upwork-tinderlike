//
//  SplashScreeViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import Foundation
import SwiftUI

class SplashScreeViewModel: ObservableObject {
    @Published var isDataLoaded = false
    @Published var isFullScreenCover = false
    static var shared = SplashScreeViewModel()

    func fetchAllAPI(completion: (()->())?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion?()
        }
    }
}
