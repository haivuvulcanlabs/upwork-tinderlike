//
//  ChatListView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

struct ChatListView: View {
    @StateObject var model = ChatListModelView()
    @State private var users = ["Glenn", "Malcolm", "Nicola", "Terri"]
    
    @State var isChatting = false
    var body: some View {
        ZStack {
            NavigationLink(isActive: $isChatting) {
                ChattingView()
            } label: {
                
            }
            
            VStack{
                BackButtonNavView(text: "Chats")
                List() {
                    ForEach(0..<model.chats.count, id: \.self) { index in
                        let chat = model.chats[index]
                        chatListView(chat: chat)
                            .listRowSeparator(.hidden)
                        
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    
                }
                .background(.black)
                .padding(.horizontal, 0)
            }
        }
        .onAppear{
            model.getChatList()
        }
        .background(.black)
    }
    
    @ViewBuilder
    func chatListView(chat: Chat) -> some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                Image("ic-thumb-1")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
                
            }
            .overlay(alignment: .trailing) {
                let isOnLine = Int.random(in: 0...100) % 3 == 0
                if isOnLine {
                    ZStack {
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 12, height: 12, alignment: .trailing)
                        
                        Circle()
                            .foregroundColor(Color(hex: "FF001A"))
                            .frame(width: 10, height: 10, alignment: .trailing)
                    }
                }
               
            }
            
            
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text("Greg")
                        .font(.roboto(.bold, size: 14))
                        .foregroundColor(Color(hex: "909093"))
                    Text(chat.message)
                        .font(.roboto(.regular, size: 12))
                        .foregroundColor(Color(hex: "909093"))
                    Spacer()
                }
                
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .bottom).foregroundColor(Color(hex: "909093")), alignment: .bottom)
            
        }
        .frame(height: 70)
        .listRowBackground(Color.black)
        .swipeActions {
            Button {
                model.removeChat(by: chat.id)
            } label: {
                Asset.Assets.icTrash.image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 20, height: 20)
            }
            .tint(.red)
        }
        .onTapGesture {
            withAnimation {
                isChatting = true
            }
        }
    }
}
