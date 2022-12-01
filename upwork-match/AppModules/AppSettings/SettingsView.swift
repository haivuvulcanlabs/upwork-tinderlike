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

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("ic-back-red")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 20, alignment: .center)
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    Spacer()
                    
                    Text("SETTINGS")
                        .foregroundColor(MyColor.red)
                    Spacer()
                }
                .frame(width: Device.width, height: 44, alignment: .center)
                
                VStack(spacing: 40){
                    ForEach(0..<model.items.count,id: \.self) { index in
                        let group = model.items[index]
                        VStack(alignment: .leading, spacing: 10) {
                            HStack{
                                Text(group.text)
                                    .foregroundColor(Color(hex: "AFAFAF"))
                                Spacer()
                            }
                            .frame(height: 25, alignment: .leading)
                            
                            VStack{
                                ForEach(0..<group.items.count, id:\.self) { index2 in
                                    HStack{
                                        Text(group.items[index2].text)
                                            .foregroundColor(Color(hex: "D7D7D7"))
                                            .frame(height: 48, alignment: .leading)
                                        Spacer()
                                        Image("ic-right-arrow")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 12, height: 12, alignment: .center)
                                    }
                                    .padding(.horizontal, 16)

                                }
                            }
                            .frame(height: CGFloat(group.items.count) * 48, alignment: .leading)
                            .background(Color(hex: "2C2C2E"))

                            .cornerRadius(13, corners: .allCorners)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)


                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding(EdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16))
                Spacer()
            }
        }
        .myBackColor()
    }
}
