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
    @StateObject var model = ChattingViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                navView
                Divider()
                Spacer()
                ScrollViewReader {(proxy: ScrollViewProxy) in
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ForEach(0..<model.chatMessages.count, id: \.self) { index in
                            buildChatMessageView(chat: model.chatMessages[index])
                        }
                        
                    }.padding(.horizontal,10)
                  
                    .background(MyColor.darkBG)
                }

                HStack {
                    ChattingTextEditor(placeholder:"Messages", text: $model.chatString)
                        .padding(.leading,10)
                    
                    Button {
                        if model.chatString.count > 0 {
                            if model.chatString.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                model.sendMessage(model.chatString)
                            }
                        } else {}
                    } label: {
                        ZStack {
                            Asset.Assets.icSend.image
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(MyColor.white)
                                .frame(width: 29, height: 29, alignment: .center)
                                .padding(.leading,2)
                            
                        } .padding(4)
                    }
                }
                
                .background(MyColor.whiteBGTab.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
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
    
    
    @ViewBuilder
    func buildChatMessageView(chat: ChatMessage) -> some View {
        HStack {
            Spacer()
            HStack {
                Text(chat.message)
                    .font(.openSans(.regular, size: 15))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(100)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .frame(minHeight: 32, alignment: .center)
            .background(.red)
            .cornerRadius(16)
        }
    }
}
