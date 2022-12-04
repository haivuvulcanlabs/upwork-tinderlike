//
//  PushNotiSettingView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 04/12/2022.
//

import Foundation
import SwiftUI

struct PushNotiSettingView: View {
    @Environment(\.presentationMode) var present

    var optionTexts: [PushOption] = PushOption.allCases
    @State var showGreeting = false
    
    var body: some View {
        VStack {
           navView
           
            VStack{
                ForEach(0..<optionTexts.count,id: \.self) { index in
                    HStack{
                        Text(optionTexts[index].text)
                            .foregroundColor(Color(hex: "#D7D7D7"))
                            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
                        Spacer()
                        
                        Toggle("", isOn: $showGreeting)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                            .padding(.horizontal, 13)

                    }
                    .frame(height: 44, alignment: .leading)
                    if index < optionTexts.count - 1 {
                        Divider()
                    }
                }
            }
            .background(Color(hex: "#2C2C2E"))
            .cornerRadius(13, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .dragAndBack()
        .myBackColor()
    }
    
    var navView: some View {
        ZStack{
            HStack{
                
                Spacer()
                Text("PUSH NOTIFICATION")
                    .font(.openSans(.bold, size: 12))
                    .foregroundColor(MyColor.red)
                Spacer()
            }
            .frame(width: Device.width, height: 44, alignment: .leading)
            
            HStack {
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: 5){
                        Asset.Assets.icBackRed.image.resizable().scaledToFit()
                            .frame(width: 12, height: 21)
                        Text("SETTINGS")
                            .font(.openSans(.bold, size: 12))
                            .foregroundColor(MyColor.red)
                    }
                    .padding(.horizontal, 10)
                }
            }
            .frame(width: Device.width, height: 44, alignment: .leading)
        }//nav
    }
}

enum PushOption: Int, CaseIterable {
    case like = 0, message
    
    var text: String {
        switch self {
        case .like:
            return "Likes"
        case .message:
            return "Messages"
        }
    }
}
