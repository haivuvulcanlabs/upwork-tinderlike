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
        .myBackColor()
    }
    
    @ViewBuilder
    func chatListView(chat: Chat) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image("ic-thumb-1")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text("Greg")
                    .font(.roboto(.bold, size: 14))
                    .foregroundColor(Color(hex: "909093"))
                Text(chat.message)
                    .font(.roboto(.regular, size: 12))
                    .foregroundColor(Color(hex: "909093"))
                
            }
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
