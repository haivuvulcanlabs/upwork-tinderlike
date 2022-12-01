//
//  ContentView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SplashScreenView()
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
