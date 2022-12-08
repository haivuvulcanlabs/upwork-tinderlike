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
            //            ZStack {
            
            TabView(selection: $selectedTab) {
                DiscoverView().tag(0)
                DiscoverView().tag(1)
                DiscoverView().tag(2)
            }.tabViewStyle(.page(indexDisplayMode: .never))
            
            //                VStack{
            //                    Spacer()
            //
            //
            //                }
            //            }
        }
        .fullScreenCover(isPresented: $isShowingBottomSheet, content: {
            //            ProfileFilterView(isActive: $isShowingBottomSheet)
            ZStack{
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Spacer()
                    BottomSheet(isShowing: $isShowingBottomSheet, content: AnyView(ProfileFilterSheet()))
                    
                   Rectangle()
                        .foregroundColor(Color.black)
                        .frame(height: Device.bottomSafeArea + 5, alignment: .center)
                    
                }
            }
            .background(BackgroundBlurView())
        })
        .myBackColor()
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
