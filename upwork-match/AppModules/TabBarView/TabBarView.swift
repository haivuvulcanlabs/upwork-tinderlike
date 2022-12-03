//
//  TabBarView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI

struct TabBarView: View {
    @State var isLoginSheet = false
    @State var selectedTab = 0
    @State var isPostCover = false
    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case 1 :
                HomeView()
            case 2:
                ChatListView()
            default :
                ProfileView()
            }
            HStack {
                TabButton(image: MyImages.icTabProfile, text: "LocalStrings.home",selectedTab: $selectedTab,index: 0)
                Spacer()
                TabButton(image: MyImages.icTabDiscover, text: "LocalStrings.Explore",selectedTab: $selectedTab,index: 1)
               
                Spacer()
                TabButton(image: MyImages.icTabChat, text: "LocalStrings.updates",selectedTab: $selectedTab,index: 2)
            }
            .padding(.horizontal,Device.width/17)
            .padding(.vertical,6)
            .background(MyColor.black.ignoresSafeArea())
        }
        .myBackColor()
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct TabButton : View {
    @State var isLoginSheet = false
    var image : Image?
    var text : String
    @Binding var selectedTab : Int
    var index : Int
    var body: some View {
        VStack {
            image?
                .resizable()
                .renderingMode(.original)
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(index == selectedTab ? MyColor.white : MyColor.textLight)
//            Text("text.localized()")
//                .font(.custom(MyFont.GilroyLight, size: 13))
//                .foregroundColor(index == selectedTab ? MyColor.white : MyColor.textLight)
        }
        .frame(height: 44)
        .onTapGesture {
            selectedTab = index
        }
    }
}
