//
//  MyPlusView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

enum MyPlus: Int, CaseIterable {
    case unlimitedLike = 0, unlimitedMsg, dontShowAge, dontShowDistance, hideProfile
    
    var text: String {
        switch self {
        case .unlimitedLike:
            return "Unlimited likes"
        case .unlimitedMsg:
            return "Unlimited messages"
        case .dontShowAge:
            return "Don´t show my age"
        case .dontShowDistance:
            return "Don´t show my distance"
        case .hideProfile:
            return "Hide my profile"
        }
    }
}

struct MyPlusView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var model = MyPlustViewModel()
    @State private var isShowSubscription = false
    
    var optionTexts: [MyPlus] = MyPlus.allCases
    
    var body: some View {
        VStack {
          
            navView
            
            VStack{
                ForEach(0..<optionTexts.count,id: \.self) { index in
                    HStack{
                        Text(optionTexts[index].text)
                            .font(.roboto(.regular, fixedSize: 16))
                            .foregroundColor(Color(hex: "#D7D7D7"))
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        Spacer()
                        
                        Toggle("", isOn: $model.plusSettings[index])
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 13))
                            .onChange(of: model.plusSettings[index]) { value in
                                // action...
                                print(value)
                                self.model.onUpdateSetting(at: index, value: value)
                            }
                    }
                    .frame(height: 44, alignment: .leading)
                    if index < optionTexts.count - 1 {
                        Divider()
                    }
                }
            }
            .background(Color(hex: "#2C2C2E"))
            .cornerRadius(13)
            Spacer()
        }
        .fullScreenCover(isPresented: $isShowSubscription, content: {
            ZStack{
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                SubscriptionView()
            }
            .background(BackgroundBlurView())
        })
        .onAppear {
            isShowSubscription = true
            model.getProfileSetting()
        }
        .padding(.horizontal, 11)
        .myBackColor()
        
    }
    
    var navView: some View {
        ZStack{
            HStack{
                Spacer()
                Text("MY PLUS")
                    .font(.openSans(.bold, size: 14))
                    .foregroundColor(MyColor.red)
                Spacer()
            }
            
            HStack{
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("DONE")
                        .font(.openSans(.bold, size: 14))
                        .foregroundColor(MyColor.red)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}


