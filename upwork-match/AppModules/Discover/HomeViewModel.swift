//
//  HomeViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import Foundation
import SwiftUI

class HomeViewModel: NSObject,ObservableObject {
    @Published var isLoading = false
    @Published var allPosts = [Profile]()

    
    func fetchData() {
        
        for i in 0 ..< 100 {
            let profile = Profile(id: i, thumbnail: "thumb_\(i)")
            allPosts.append(profile)
        }
    }
}
