//
//  SignupInfoView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI
import Combine

struct SignupInfoView: View {
    var step: SignupStep
    @Binding var tabIndex: Int
    @State private var inputText: String = "john"
    @StateObject var model = SignUpViewModel()
    
    @State var birthday: [String] = ["","","","","",""]
    @FocusState var field: BirthdayField?
    var allBirthdayFields: [BirthdayField] = BirthdayField.allCases

    var body: some View {
        ZStack{
            VStack {
                Text(step.titleText)
                    .foregroundColor(Color(hex: "C1C1C1"))
                    .font(.system(size: 22, weight: .semibold))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                if let subTitle = step.subtitle, !subTitle.isEmpty {
                    Text(subTitle)
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .font(.system(size: 10, weight: .medium))
                        .padding(.vertical, 2)
                }
                
                switch step {
                case .name:
                    inputTextView(text: $inputText)
                        .frame(width: Device.width * 265.0 / 375.0, height: 40, alignment: .center)
                case .birthday:
                    TextField("", text: $inputText)
                    HStack {
                        ForEach(0..<6, id: \.self) {index in
                            VStack{
                                TextField("", text: $birthday[index])
                                    .focused($field, equals: allBirthdayFields[index])
                                    .foregroundColor(Color(hex: "999999"))
                                    .multilineTextAlignment(.center)
                                    .onReceive(Just($birthday[index])) { _ in
                                        if birthday[index].count > 1 {
                                            birthday[index] = String(birthday[index].prefix(1))
                                        }
                                    }
                                
                                Rectangle()
                                    .foregroundColor(MyColor.red)
                                    .background(MyColor.red)
                                    .frame(height: 3)
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(width: 14, height: 40, alignment: .center)
                            .onAppear{
                                field = .month1
                            }
                            
                        }
                    }
                    
                case .gender:
                    selectGenderView
                case .bio:
                    TextField("Type here...", text: $inputText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "999999"))
                        .padding(.horizontal, 20)
                case .photo:
                    selectProfileImages
                default:
                    EmptyView()
                }
                Spacer()
                
                Button {
                    if step == .birthday {
                        model.onAddBithday()
                    }
                    tabIndex += 1

                } label: {
                    buildButton(with: "CONTINUE")
                }
            }

            BottomSheet(isShowing: $model.imagePicker, bgColor: .clear, content: AnyView(cameraActionSheet))
            BottomSheet(isShowing: $model.isShowingDelete, bgColor: .clear, content: AnyView(deleteSheet))
        }
        .fullScreenCover(isPresented: $model.isFilePicker, content: {
            ImagePicker(image: $model.profileImages[0], filename: $model.fileName, imagePickerType: .photoLibrary, videoURL: .constant(URL(string: "www.retrytech.com")!))
        })
        .fullScreenCover(isPresented: $model.isCameraOn) {
            ImagePicker(image: $model.selfie, filename: Binding.constant(""), imagePickerType: .camera, videoURL: .constant(URL(string: "www.retrytech.com")!))
        }
        .myBackColor()
    }
    
    @ViewBuilder
    func inputTextView(text: Binding<String>) -> some View {
        VStack{
            TextField("", text: text)
                .foregroundColor(Color(hex: "999999"))
                .multilineTextAlignment(.center)
            Rectangle()
                .foregroundColor(MyColor.red)
                .background(MyColor.red)
                .frame(height: 3)
                .frame(maxWidth: .infinity)
        }
    }

    var selectGenderView: some View {
        VStack(spacing: 20) {
            Button {
                
            } label: {
                buildButton(with: "FEMALE")
            }
            
            
            Button {
                
            } label: {
                buildButton(with: "MALE")
                
            }
        }
        .frame(width: 260, alignment: .center)
        .padding(.vertical, 20)
    }
    
    var selectProfileImages: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                if model.profileImages.isEmpty {
                    EmptyView()
                } else {
                    
                    ReorderableForEach(items: model.profileImageData) { item in
                        ProfileImageView(item: item, imagePicker: $model.imagePicker, isDelete: $model.isShowingDelete) {
                            model.selectedGridItem = item
                        }
                        .background(.red)
                    } moveAction: { from, to in
                        model.profileImages.move(fromOffsets: from, toOffset: to)
                    }
                }
            }
            
            Text("Hold, drag and drop to reorder your photos")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(MyColor.hex4d4d4d)
                .padding(.vertical, 20)
        }
    }
    
    var cameraActionSheet : some View {
        VStack {
            Spacer()
            CustomActionSheet(onSelectProfileOption: { index in
                switch index {
                case 0:
                    model.isFilePicker = true
                case 1: break
                default: break
                    
                }
            }, options: ["Camera", "Gallery"])
        }
        .background(Color.clear)
        .ignoresSafeArea()
        
    }
    
    var deleteSheet : some View {
        CustomActionSheet(onSelectProfileOption: { index in
            switch index {
            case 0: break
            case 1: break
            default: break
                
            }
        }, options: ["Delete"])
        .ignoresSafeArea()
        
    }
}



