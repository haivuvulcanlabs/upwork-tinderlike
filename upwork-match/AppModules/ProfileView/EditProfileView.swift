//
//  SettingsView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var model = EditViewModel()

    @State var images: [GridData] = ["ic-thumb-1","ic-thumb-2","ic-thumb-3", "ic-thumb-4", "ic-thumb-5", "ic-thumb-2","","", ""].compactMap({GridData(id: Int.random(in: 0...100), thumbURL: $0)})
    
    @State var aboutmeText: String = ""
    @State var isActiveProfileView: Bool = false
    var body: some View {
        ZStack {
            NavigationLink(isActive: $isActiveProfileView) {
                ProfileAndLikeView()
            } label: {
            }

            ScrollViewReader { proxy in
                VStack {
                    HStack {
                        Button {
                            isActiveProfileView.toggle()
                        } label: {
                            Text("PREVIEW")
                                .font(.openSans(.bold, size: 14))
                                .foregroundColor(MyColor.red)
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        Spacer()
                        
                        Text("EDIT PROFILE")
                            .font(.openSans(.bold, size: 14))
                            .foregroundColor(MyColor.red)
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Text("DONE")
                                .font(.openSans(.bold, size: 14))
                                .foregroundColor(MyColor.red)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))

                    }
                    .frame(width: Device.width, height: 44, alignment: .center)
                    //end navigation View
                    VStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                            if images.isEmpty {
                                EmptyView()
                            } else {
                                
                                ReorderableForEach(items: images) { item in
                                    ProfileImageView(item: item, imagePicker: $model.imagePicker, isDelete: $model.isShowingDelete)
                                        .background(.red)
                                } moveAction: { from, to in
                                    images.move(fromOffsets: from, toOffset: to)
                                }
                            }
                        }
                    }
                    

                    Text("Hold, drag and drop to reorder your photos")
                        .font(.openSans(.semiBold, size: 12))
                        .foregroundColor(MyColor.hex4d4d4d)
                        .padding(.vertical, 20)
                    Text("About me")
                        .font(.openSans(.semiBold, size: 17))
                        .foregroundColor(MyColor.hex4d4d4d)

                    TextField("Type here", text: $aboutmeText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(MyColor.hex4d4d4d)
                        .font(.openSans(.semiBold, size: 17))
                        .padding(.horizontal, 10)


                    Spacer()
                }

            }
            
            BottomSheet(isShowing: $model.imagePicker, bgColor: .clear, content: AnyView(cameraActionSheet))
            BottomSheet(isShowing: $model.isShowingDelete, bgColor: .clear, content: AnyView(deleteSheet))

        }
        .tapAndHideKeyboard()
        .myBackColor()
    }
    
    var cameraActionSheet : some View {
        CustomActionSheet(onSelectProfileOption: { index in
            switch index {
            case 0: break
            case 1: break
            default: break
                
            }
        }, options: ["Camera", "Gallery"])
    }
    
    var deleteSheet : some View {
        CustomActionSheet(onSelectProfileOption: { index in
            switch index {
            case 0: break
            case 1: break
            default: break
                
            }
        }, options: ["Delete"])
    }
}

struct ProfileImageView: View {
    var item: GridData
    @Binding var imagePicker: Bool
    @Binding var isDelete: Bool
    var selectHandler: (()->())?
    var body: some View {
        ZStack {
//            if !item.thumbURL.isEmpty {
            if let uiimage = item.uiImage {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Device.width/3, height: Device.width/3, alignment: .center)
                
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


struct GridData: Identifiable, Equatable {
    let id: Int
    let thumbURL: String
    var uiImage: UIImage?
}
