//
//  ChatingView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 04/12/2022.
//

import Foundation
import SwiftUI

struct ChattingView: View {
    @Environment(\.presentationMode) var present

    var body: some View {
        ZStack {
            VStack {
                navView
                Divider()
                Spacer()
            }
        }
        .dragAndBack()
        .myBackColor()
    }
    
    var navView: some View {
        HStack {
            Button {
                present.wrappedValue.dismiss()
            } label: {
                Asset.Assets.icBackRed.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 21, alignment: .center)
            }
            .frame(width: 40, height: 40, alignment: .center)
            
            Asset.Assets.icThumb5.image
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .clipShape(Circle())
            
            Text("Sara")
                .foregroundColor(MyColor.red)
                .font(.openSans(.bold, size: 14))
            
            Spacer()
            
            Button {
                
            } label: {
                Asset.Assets.icShieldRed.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28, alignment: .center)
            }
            .frame(width: 40, height: 40, alignment: .center)
        }
        .frame(width: Device.width, height: 44, alignment: .center)
    }
}
