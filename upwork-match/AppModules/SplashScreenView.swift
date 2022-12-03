//
//  SplashScreenView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI

class AppFlow: ObservableObject {
    static let shared = AppFlow()
    @Published var isLoggedIn = false
}

struct SplashScreenView: View {
    @StateObject var model = SplashScreeViewModel()
    @StateObject var appflow = AppFlow.shared

    var body: some View {
        ZStack {
            NavigationLink(isActive: $model.isDataLoaded, destination: {
                if appflow.isLoggedIn {
                    TabBarView()
                } else {
                    CreateAccountView()
                }
            }, label: {})
            .frame(width: 0, height: 0, alignment: .center)
                            
            MyImages.icLogo
                .resizable()
                .scaledToFit()
                .frame(width: Device.width-120)
                .padding(.bottom)
        }
        .onAppear(perform: {
            UIApplication.shared.isIdleTimerDisabled = true
            model.fetchAllAPI()
        })
        .myBackColor()
        .ignoresSafeArea()

//        .onChange(of: model.coins) { newValue in
//            coins = newValue
//        }
    }
}
