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
    @State var my_identity = "hai_vu"
    var body: some View {
        ZStack {
            VStack {
                navView
                Divider()
                Spacer()
                ScrollViewReader {(proxy: ScrollViewProxy) in
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ForEach(0..<model.chatMessages.count, id: \.self) { index in
                            let chatMessage = model.chatMessages[index]
                            let isMyMsg = chatMessage.senderUser.user_identity == my_identity
                            TextChatRow(isMyMsg: isMyMsg, chatData: chatMessage)
                        }
                        
                    }.padding(.horizontal,10)
                    
                        .background(MyColor.darkBG)
                }
                
                HStack {
                    ChattingTextEditor(placeholder:"Type a message...", text: $model.chatString)
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
                .padding(.horizontal, 24)
//                .background(MyColor.red.opacity(0.15))
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.red)
                        .padding(.horizontal, 24)

                }
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


struct TextChatRow : View {
    var isMyMsg : Bool  //chatData.senderUser.user_identity == user.user_identity
    var chatData : ChatMessage
    var body: some View {
        HStack{
            if !isMyMsg {
                VStack() {
                    Asset.Assets.icThumb1.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                
                text
                //            ChatTime(time: chatData.time)
                Spacer()
            } else {
                //            ChatTime(time: chatData.time)
                
                Spacer()
                
                text
            }
        }
    }
    
    var text : some View {
        Text(chatData.message)
            .foregroundColor(MyColor.white)
            .font(.openSans(.regular, size: 15))
            .padding(8)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .lineSpacing(2)
            .background(!isMyMsg ? MyColor.red.opacity(0.6) : MyColor.red.opacity(1))
            .cornerRadius(16)
            .padding(1)
    }
}
