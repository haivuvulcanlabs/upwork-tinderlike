//
//  SplashScreenView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var model = SplashScreeViewModel()
    @AppStorage(Defaults.coins) var coins = 0
    @AppStorage(Defaults.userID) var userID = 0
    
    var body: some View {
        ZStack {
            NavigationLink(isActive: $model.isDataLoaded, destination: {
                TabBarView()
            }, label: {}).frame(width: 0, height: 0, alignment: .center)
                            
            MyImages.icLogo
                .resizable()
                .scaledToFit()
                .frame(width: Device.width-120)
                .padding(.bottom)
        }
        .onAppear(perform: {
            UIApplication.shared.isIdleTimerDisabled = true
            AllStaticData.userID = userID
            model.fetchAllAPI()
        })
        .myBackColor()
        .ignoresSafeArea()
//        .onChange(of: model.coins) { newValue in
//            coins = newValue
//        }
    }
}
