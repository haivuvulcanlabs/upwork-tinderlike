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
    @State var isDeleteAccountActive = false

    var body: some View {
        ZStack {
            NavigationLink("", isActive: $isPushSettingActive) {
                PushNotiSettingView()
            }
            NavigationLink("", isActive: $isDeleteAccountActive) {
                DeleteAccountView()
            }
            
            VStack {
                BackButtonNavView(image: Asset.Assets.icBackRed.image, text: "SETTINGS")
                VStack(spacing: 40){
                    ForEach(0..<model.items.count,id: \.self) { index in
                        let group = model.items[index]
                        VStack(alignment: .leading, spacing: 10) {
//                        GroupBox {
                            HStack{
                                Text(group.text)
                                    .font(.openSans(.bold, fixedSize: 14))
                                    .foregroundColor(Color(hex: "AFAFAF"))
                                Spacer()
                            }
                            .frame(height: 25, alignment: .leading)
                            
                            VStack(){
                                ForEach(0..<group.items.count, id:\.self) { index2 in
                                    let setting = group.items[index2]
                                    VStack(alignment: .center, spacing: 0) {
                                        HStack(alignment: .center){
                                            Text(setting.text)
                                                .font(.roboto(.regular, fixedSize: 17))
                                                .foregroundColor(Color(hex: "D7D7D7"))
                                            Spacer()
                                            Asset.Assets.icRightArrow.image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 12, height: 12, alignment: .center)
                                        }
                                        .frame(height: 48, alignment: .leading)
                                        .padding(.horizontal, 16)
                                        .onTapGesture {
                                            if setting == .pushNotification {
                                                isPushSettingActive.toggle()
                                            } else if setting == .deleteAccount {
                                                isDeleteAccountActive.toggle()
                                            }
                                        }
                                        if index2 < group.items.count - 1 {
                                           Divider()
                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                .frame(height: 0.5)
                                                .overlay{
                                                    Color(hex: "A5A5A5")
                                                }
                                        }
                                    }
                                    .frame(height: 48, alignment: .leading)

                                }
                            }
                            .frame(height: CGFloat(group.items.count) * 48, alignment: .leading)
                            .background(Color(hex: "2C2C2E"))

                            .cornerRadius(13, corners: .allCorners)
                        }
//                        .groupBoxStyle(ColoredGroupBox())
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)


                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        model.signOut()
                    }, label: {
                        Spacer()
                        Text("Sign out")
                            .multilineTextAlignment(.center)
                            .font(.roboto(.regular, fixedSize: 17))
                            .foregroundColor(Color(hex: "D7D7D7"))
                            .frame(height: 48, alignment: .center)
                        Spacer()
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 16)
                    .background(Color(hex: "2C2C2E"))
                    .cornerRadius(13)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding(EdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16))
                Spacer()
            }
        }
        .myBackColor()
    }
}


struct ColoredGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                    .font(.headline)
                Spacer()
            }
            
            configuration.content
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
            .fill(Color(hex: "2C2C2E"))) // Set your color here!!
    }
}
