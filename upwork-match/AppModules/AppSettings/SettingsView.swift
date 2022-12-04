//
//  SettingsView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var model = SettingViewModel()

    @State var isPushSettingActive = false
    var body: some View {
        ZStack {
            NavigationLink("", isActive: $isPushSettingActive) {
                PushNotiSettingView()
            }
            VStack {
                BackButtonNavView(image: Asset.Assets.icBackRed.image, text: "SETTINGS")
                VStack(spacing: 40){
                    ForEach(0..<model.items.count,id: \.self) { index in
                        let group = model.items[index]
                        VStack(alignment: .leading, spacing: 10) {
                            HStack{
                                Text(group.text)
                                    .font(.openSans(.bold, fixedSize: 14))
                                    .foregroundColor(Color(hex: "AFAFAF"))
                                Spacer()
                            }
                            .frame(height: 25, alignment: .leading)
                            
                            VStack{
                                ForEach(0..<group.items.count, id:\.self) { index2 in
                                    let setting = group.items[index2]
                                    HStack{
                                        Text(setting.text)
                                            .font(.roboto(.regular, fixedSize: 17))
                                            .foregroundColor(Color(hex: "D7D7D7"))
                                            .frame(height: 48, alignment: .leading)
                                        Spacer()
                                        Image("ic-right-arrow")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 12, height: 12, alignment: .center)
                                    }
                                    .padding(.horizontal, 16)
                                    .onTapGesture {
                                        if setting == .pushNotification {
                                            isPushSettingActive.toggle()
                                        }
                                    }
                                    if index2 < group.items.count - 1 {
                                        Rectangle()
                                            .foregroundColor(Color(hex: "A5A5A5"))
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .frame(height: 0.5)

                                    }

                                }
                            }
                            .frame(height: CGFloat(group.items.count) * 48, alignment: .leading)
                            .background(Color(hex: "2C2C2E"))

                            .cornerRadius(13, corners: .allCorners)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)


                    }
                    
                    Spacer()
                    
                    HStack{
                        Text("Sign out")
                            .multilineTextAlignment(.center)
                            .font(.roboto(.regular, fixedSize: 17))
                            .foregroundColor(Color(hex: "D7D7D7"))
                            .frame(height: 48, alignment: .center)
                    }
                    .padding(.horizontal, 16)
                    .background(Color(hex: "2C2C2E"))
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding(EdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16))
                Spacer()
            }
        }
        .myBackColor()
    }
}
