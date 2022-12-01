//
//  HomeView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct DiscoverView: View {
    
    @StateObject var model = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack{
                EmptyView()
            }
            .padding(.horizontal,10)
            .frame(height: 55, alignment: .center)
            
            Spacer()
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    
                    VStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                            if model.allPosts.isEmpty && model.isLoading {
                                EmptyView()
                            } else {
                                ForEach(0..<model.allPosts.count,id: \.self) { index in
                                    NavigationLink {
                                        ProfileAndLikeView()
                                    } label: {
                                        photoView(post: model.allPosts[index], index: index)
                                            .onAppear {
                                                if model.allPosts.last?.id == model.allPosts[index].id {
                                                }
                                            }
                                            .contextMenu {
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
            .background(MyColor.whiteBGTab)
        }
        .navigationBarHidden(true)
        .background(MyColor.whiteBGTab.ignoresSafeArea())
        .onAppear {
            model.fetchData()
        }
    }
}

func photoView(post : Profile,index : Int) -> some View {
    
    ZStack(alignment: .topLeading) {
        Image("ic-thumb-1")
            .resizable()
            .scaledToFill()
            .frame(width: Device.width/3, height: Device.width/3, alignment: .center)
        VStack{
            Spacer()
            HStack{
                Text("Anna")
                    .foregroundColor(MyColor.white)
                    .padding(EdgeInsets(top: 0, leading: 2, bottom: 2, trailing: 0))
                Spacer()
            }
        }
        
    }
}

