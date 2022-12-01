//
//  HomeView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @State var selectedTab = 0
    @State var isActive : Bool = false
    @State var isShowingBottomSheet = false

    var body: some View {
        VStack {
            HStack {
                Text("DISCOVERY")
                    .font(.custom(MyFont.GilroySemibold, size: 18))
                    .foregroundColor(selectedTab == 0 ? MyColor.red : MyColor.red50)
                    .padding(10)
                    .onTapGesture {
                        selectedTab = 0
                    }
                Text("NEARBY")
                    .font(.custom(MyFont.GilroySemibold, size: 18))
                    .foregroundColor(selectedTab == 1 ? MyColor.red : MyColor.red50)
                    .onTapGesture {
                        selectedTab = 1
                    }
                Text("FRESH")
                    .font(.custom(MyFont.GilroySemibold, size: 18))
                    .foregroundColor(selectedTab == 2 ? MyColor.red : MyColor.red50)
                    .onTapGesture {
                        selectedTab = 2
                    }
                
                
                Spacer()
                
                Button {
                    isShowingBottomSheet.toggle()
                } label: {
                    Image("ic-filter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                
            }
            .padding(.horizontal,10)
            .frame(height: 55, alignment: .center)
            ZStack {
                
                TabView(selection: $selectedTab) {
                    DiscoverView().tag(0)
                    DiscoverView().tag(1)
                }.tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack{
                    Spacer()
                    BottomSheet(isShowing: $isShowingBottomSheet, content: AnyView(ProfileFilterSheet()))

                }
            }
        }
        .myBackColor()
    }
}
