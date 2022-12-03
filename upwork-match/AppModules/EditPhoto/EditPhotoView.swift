//
//  EditPhotoView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

struct EditPhotoView: View {
    @State private var imageSize: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-back-red"), text: "Move and Scale", rightText: "DONE")
                
                //                ZoomableScrollView {
                //                    Image("im-profile-full")
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fill)
                //                }
                //                .clipped()
                //                .background(Color.red)
                if let uiImage = UIImage(named: "im-profile-full") {
                    
                    GeometryReader { proxy in
                        Image(uiImage: uiImage)
                            .resizable()
                            .onAppear {
                                self.imageSize = uiImage.size
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .clipShape(Rectangle())
                            .modifier(ImageModifier(contentSize: imageSize))
                        
                    }
                    .overlay {
                        gridView
                           
                    }
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .myBackColor()
    }
    
    var gridView: some View {
        VStack(spacing: 0) {
            
            Divider()
                .frame(height: 1)
                .frame(minWidth: 0,maxWidth: .infinity)
            
                .background(Color.white)
            ForEach(0..<7) { index in
                HStack(spacing: 0) {
                    
                    Divider()
                        .frame(width: 1)
                        .frame(minHeight: 0,maxHeight: .infinity)
                    
                        .background(Color.white)
                    
                    ForEach(0..<4) { index in
                        Spacer()
                        Divider()
                            .frame(width: 1)
                            .frame(minHeight: 0,maxHeight: .infinity)
                        
                            .background(Color.white)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.clear)
                
                Divider()
                    .frame(height: 1)
                    .frame(minWidth: 0,maxWidth: .infinity)
                
                    .background(Color.white)
            }
            
            EmptyView()
                .frame(height: Device.bottomSafeArea, alignment: .bottom)
        }
    }
}
