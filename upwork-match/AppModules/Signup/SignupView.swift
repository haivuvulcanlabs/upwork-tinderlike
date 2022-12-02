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
                ZStack {
                    BackButtonNavView(image: Image("ic-back-red"))
                    HStack {
                        Spacer()
                        PageControl(numberOfPages: 4, currentPage: $selectedTab)
                        Spacer()
                        if selectedTab >= 3 {
                            Button {
                                
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
                    SignupInfoView(step: .name).tag(0)
                    SignupInfoView(step: .birthday).tag(1)
                    SignupInfoView(step: .gender).tag(2)
                    SignupInfoView(step: .bio).tag(3)
                    SignupInfoView(step: .photo).tag(4)

                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
        }
        .myBackColor()
    }
}
