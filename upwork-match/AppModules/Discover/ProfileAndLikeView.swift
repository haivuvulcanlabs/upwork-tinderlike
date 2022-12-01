//
//  ProfileAndLikeView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI
import UIKit

struct ProfileAndLikeView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var showingOptions = false
    @State private var selection = "None"
    @State private var showingBlockAlert = false
    @State private var showingReportAlert = false
    
    @State private var animateLike = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView{
                LazyHStack {
                    PageView()
                }
                
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                VStack(){
                    EmptyView()
                        .frame(height: Device.height - 200)
                    HStack{
                        Text("Elisabeth")
                            .foregroundColor(.white)
                        Text("22")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack{
                        Image("ic-pin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                        Text("10 km away")
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    Text("I am not the type of girl you have to hold in farts for, but rather the type of girl you want to hold in farts for!")
                        .foregroundColor(.white)
                }
                .frame(height: Device.height, alignment: .bottom)
                .padding(.horizontal, 14)
                
            }
            
            VStack{
                topView
                Spacer()
                HStack{
                    Spacer()
                    Image("ic-chat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding(.horizontal, 10)
                    
                    Button {
                        withAnimation(Animation.easeInOut(duration: 1).repeatCount(5, autoreverses: true)) {
                            animateLike = true
                        }
                        
                    } label: {
                        Image("ic-heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35, alignment: .center)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
            
            BottomSheet(isShowing: $showingOptions, bgColor: .clear, content: AnyView(profileOpionView))
            
            if showingBlockAlert {
                CustomAlert(presentAlert: $showingBlockAlert, alertType: .error(title: "Block", message: "They won´t be able to contact or see your profile anymore. Are you sure you want to block this user?"), isShowVerticalButtons: false, optionTexts: ["Cancel", "Ok"]){ index in
                    withAnimation {
                        showingBlockAlert.toggle()
                    }
                }
            }
            
            if showingReportAlert {
                CustomAlert(presentAlert: $showingReportAlert, alertType: .error(title: "Report", message: "Select a reason"), isShowVerticalButtons: true, optionTexts: ["Spam", "Fake", "Scam"]){ index in
                    withAnimation {
                        showingReportAlert.toggle()
                    }
                }
            }
            
            if animateLike {
                VStack{
                    Spacer()
                    Image("ic-big-fill-heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150, alignment: .center)
                        .scaleEffect(animateLike ? 1 : 0.5)
                        .opacity(animateLike ? 1 : 0.5)
                    Spacer()
                }
            }
        }
        .myBackColor()
    }
    
    var topView: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("ic-close-white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12, alignment: .center)
                
            }
            .frame(width: 30, height: 30)
            .padding(.horizontal, 10)
            
            Spacer()
            Button {
                showingOptions.toggle()
            } label: {
                Image("ic-shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18, alignment: .center)
            }
            .frame(width: 30, height: 30)
            .padding(.horizontal, 10)
            
        }
        .frame(height: 44)
    }
    
    var profileOpionView: some View {
        ProfileOptionView(onSelectProfileOption: { option in
            showingOptions = false
            switch option{
            case .cancel: break
            case .report:
                showingReportAlert = true
            case .block:
                showingBlockAlert = true
            }
        })
    }
}


struct PageView: View {
    var body: some View {
        TabView {
            ForEach(0..<30) { i in
                ZStack {
                    Color.black
                    Image("ic-profile-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct ProfileOptionView: View {
    var onSelectProfileOption: ((ProfileOptions) -> Void)?
    var body: some View {
        
        VStack(spacing: 0) {
            Button {
                onSelectProfileOption?(.report)
            } label: {
                Text("Report")
                    .foregroundColor(.red)
                    .background(Color(hex: "#252525"))
                    .frame(height: 60, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color(hex: "#252525"))
            .cornerRadius(13, corners: [.topLeft, .topRight])
            
            Divider()
            Button {
                onSelectProfileOption?(.block)
                
            } label: {
                Text("Block")
                    .foregroundColor(.red)
                    .background(Color(hex: "#252525"))
                    .frame(height: 60, alignment: .center)
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color(hex: "#252525"))
            .cornerRadius(13, corners: [.bottomLeft, .bottomRight])
            
            Divider()
                .background(Color.clear)
                .foregroundColor(.clear)
                .frame(height: 10)
            
            Button {
                onSelectProfileOption?(.cancel)
                
            } label: {
                Text("Cancel")
                    .foregroundColor(.white)
                    .background(Color(hex: "#252525"))
                    .frame(height: 60, alignment: .center)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color(hex: "#252525"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .cornerRadius(13, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
            
            Rectangle()
                .background(Color.clear)
                .foregroundColor(.clear)
                .frame(height: Device.bottomSafeArea)
        }
        .background(Color.clear)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
    }
}


enum ProfileOptions: Int {
    case block = 1
    case report = 2
    case cancel = 0
}
