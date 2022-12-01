//
//  MyPlusView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

struct MyPlusView: View {
    @Environment(\.presentationMode) var presentationMode

    var optionTexts: [String] = ["Unlimited likes", "Unlimited messages", "Don´t show my age", "Don´t show my distance", "Hide my profile"]
    
    @State private var showGreeting = true
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("MY PLUS")
                    .foregroundColor(MyColor.red)
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("DONE")
                        .foregroundColor(MyColor.red)
                }
                .padding(.horizontal, 10)

            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            VStack{
                ForEach(0..<optionTexts.count,id: \.self) { index in
                    HStack{
                        Text(optionTexts[index])
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

            Spacer()
        }
        .padding(.horizontal, 11)
        .myBackColor()

    }
}
