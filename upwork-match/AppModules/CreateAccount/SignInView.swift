//
//  SignInView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 07/12/2022.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @State var selectedTab = 0
    var body: some View {
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-close-red"), text: "Sign in")
                
                TabView(selection: $selectedTab) {
                    InputPhoneNumberView(step: .inputPhone, tabIndex: $selectedTab).tag(0)
                    InputPhoneNumberView(step: .inputCode, tabIndex: $selectedTab).tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
        }
        .myBackColor()
    }
}
