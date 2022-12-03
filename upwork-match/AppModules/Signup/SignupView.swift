//
//  SignupView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation

import SwiftUI
import SDWebImageSwiftUI

struct SignupView: View {
    @State private var selectedTab = 2
    @StateObject private var model = SignUpViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    BackButtonNavView(image: Image("ic-back-red"))
                    HStack {
                        Spacer()
                        PageControl(numberOfPages: 4, currentPage: $selectedTab)
                        Spacer()
                        if selectedTab >= 3 {
                            Button {
                                AppFlow.shared.isLoggedIn = true
                            } label: {
                                Text("SKIP")
                                    .foregroundColor(MyColor.red)
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                }
                
                TabView(selection: $selectedTab) {
                    SignupInfoView(step: .name, tabIndex: $selectedTab).tag(2)                    .gesture(DragGesture())

                    SignupInfoView(step: .birthday, tabIndex: $selectedTab).tag(3)
                    SignupInfoView(step: .gender, tabIndex: $selectedTab).tag(4)
                    SignupInfoView(step: .bio, tabIndex: $selectedTab).tag(5)
                    SignupInfoView(step: .photo, tabIndex: $selectedTab).tag(6)
                    WellcomeView().tag(7)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
        }
        .myBackColor()
    }
}
