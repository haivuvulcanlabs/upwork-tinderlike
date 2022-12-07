//
//  SinupImageView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 07/12/2022.
//

import SwiftUI

struct GridImageData: Identifiable, Equatable {
    let id: Int
    var uiImage: UIImage?
}


struct GridSelectImageView: View {
    var item: GridImageData
    @Binding var imagePicker: Bool
    @Binding var isDelete: Bool
    var selectHandler: (()->())?
    var body: some View {
        ZStack {
//            if !item.thumbURL.isEmpty {
            if let uiimage = item.uiImage {
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Device.width/3, height: Device.width/3, alignment: .center)
                    .contentShape(Rectangle())
                    .clipped()
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            isDelete = true
                            selectHandler?()
                        } label: {
                            Asset.Assets.icRemove.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                            
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                    }
                    Spacer()
                }
            } else {
                Button {
                    imagePicker = true
                    selectHandler?()
                } label: {
                    Asset.Assets.icPlus.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15, alignment: .center)
                }
                .frame(width: Device.width/3, height: Device.width/3, alignment: .center)
                .background(Color(hex: "#1C1C1E"))
            }
           
        }
    }
}

