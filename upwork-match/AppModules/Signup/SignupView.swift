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
    @State private var selectedTab = 0
    @StateObject private var model = SignUpViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if selectedTab < 7 {
                    ZStack {
                            BackButtonNavView(image: Image("ic-back-red"))
    //                    HStack {
                            Spacer()
                            if selectedTab < 2 {
                                Text("Sign up")
                                    .font(.openSans(.bold, size: 14))
                                    .foregroundColor(MyColor.red)
                            } else{
                                
                                PageControl(numberOfPages: 7, currentPage: $selectedTab)
                            }
    //                        Spacer()
                            if selectedTab >= 3{
                                HStack {
                                    Spacer()
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
    //                    }
                    }
                }
                
                TabView(selection: $selectedTab) {
                    InputPhoneNumberView(isLoginFlow: false, step: .inputPhone, tabIndex: $selectedTab).tag(0)
                    InputPhoneNumberView(isLoginFlow: false, step: .inputCode, tabIndex: $selectedTab).tag(1)
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
