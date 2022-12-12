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
    @State private var refresh: Bool = false
    @StateObject var model = HomeViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    PullToRefreshSwiftUI(needRefresh: $refresh,
                                         coordinateSpaceName: "pullToRefresh") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation { refresh = false }
                        }
                    }
                    VStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                            if model.allProfiles.isEmpty && model.isLoading {
                                EmptyView()
                            } else {
                                ForEach(0..<model.allProfiles.count,id: \.self) { index in
                                    NavigationLink {
                                        ProfileAndLikeView()
                                    } label: {
                                        photoView(post: model.allProfiles[index], index: index)
                                            .onAppear {
                                                if model.allProfiles.last?.id == model.allProfiles[index].id {
                                                }
                                            }
                                            .contextMenu {
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .refreshable {
                            print("Do your refresh work here")
                        }
                    }
                }
                
            }
            .background(MyColor.whiteBGTab)
        }
        .navigationBarHidden(true)
        .background(MyColor.whiteBGTab.ignoresSafeArea())
        .onAppear {
            refresh = false
            model.fetchData()
        }
    }
    
    func photoView(post : Profile,index : Int) -> some View {
        
        ZStack(alignment: .topLeading) {
            Image(post.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: Device.width/3, height: Device.width/3, alignment: .center)
            VStack{
                Spacer()
                HStack(spacing: 3){
                    Text("Anna")
                        .font(.openSans(.semiBold, size: 18))
                        .foregroundColor(MyColor.white)
                        .padding(EdgeInsets(top: 0, leading: 4, bottom: 2, trailing: 0))
                    
                    Circle()
                        .foregroundColor(Color(hex: "#6CF32D"))
                        .frame(width: 5, height: 5)
                    Spacer()
                }
            }
            
        }
    }
}

