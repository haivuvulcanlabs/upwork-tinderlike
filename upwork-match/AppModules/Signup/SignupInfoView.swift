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
    @State private var inputText: String = ""
    @StateObject var model = SignUpViewModel()
    @State var birthday: [String] = ["","","","","","","",""]
    @FocusState var field: BirthdayField?
    var allBirthdayFields: [BirthdayField] = BirthdayField.allCases
    @State var isCameraOn = false
    
    var body: some View {
        ZStack{
            VStack {
                Text(step.titleText)
                    .foregroundColor(Color(hex: "C1C1C1"))
                    .font(.montserrat(.semiBold, size: 22))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                if let subTitle = step.subtitle, !subTitle.isEmpty {
                    Text(subTitle)
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .font(.system(size: 10, weight: .medium))
                        .padding(.vertical, 2)
                }
                
                switch step {
                case .name:
                    inputTextView()
                        .frame(width: Device.width * 265.0 / 375.0, height: 40, alignment: .center)
                case .birthday:
                    HStack(spacing: 1) {
                        ForEach(0..<birthday.count, id: \.self) {index in
                            
                            inputBirthdateView(index: index)
                        }
                    }
                    
                case .gender:
                    selectGenderView
                case .bio:
                    bioView
                case .photo:
                    selectProfileImages
                default:
                    EmptyView()
                }
                
                if let errorMessage = model.errorMessage, !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(.montserrat(.regular, size: 11))
                        .foregroundColor(Color(hex: "#FF001A"))
                }
                Spacer()
                
                Button {
                    
                    tabIndex += 1
                    
                } label: {
                    buildButton(with: "CONTINUE")
                }.disabled(!model.isVerified)
            }
            
            BottomSheet(isShowing: $model.imagePicker, bgColor: .clear, content: AnyView(cameraActionSheet))
            BottomSheet(isShowing: $model.isShowingDelete, bgColor: .clear, content: AnyView(deleteSheet))
        }
        .fullScreenCover(isPresented: $model.isFilePicker, content: {
            if let selected = model.profileImageId,
                let index = model.profileImageData.firstIndex(where: {$0.id == selected}) {

                ImagePicker(image: $model.profileImageData[index].uiImage, filename: $model.fileName, imagePickerType: .photoLibrary, videoURL: .constant(URL(string: "www.retrytech.com")!))
            }
        })
        .fullScreenCover(isPresented: $model.isCameraOn) {
            ImagePicker(image: $model.selfie, filename: Binding.constant(""), imagePickerType: .camera, videoURL: .constant(URL(string: "www.retrytech.com")!))
        }
        .fullScreenCover(isPresented: $isCameraOn, content: {
            if let selectedId = model.profileImageId, let profileImage = model.profileImageData.firstIndex(where: {$0.id == selectedId}) {
                CameraView(image: $model.profileImageData[profileImage].uiImage, isActive:  $isCameraOn)
            }
        })
        .tapAndHideKeyboard()
        .myBackColor()
    }
    
    @ViewBuilder
    func inputTextView() -> some View {
        VStack{
            
            TextField("Name", text: $inputText, onEditingChanged: {_ in
                print("Changed")
                model.onNameChanged(name: inputText)
                
            })
            
            .onChange(of: inputText, perform: { newValue in
                model.onNameChanged(name: newValue)
                
            })
            .font(.montserrat(.medium, size: 18))
            .foregroundColor(Color(hex: "C1C1C1"))
            .multilineTextAlignment(.center)
            
            Rectangle()
                .foregroundColor(MyColor.red)
                .background(MyColor.red)
                .frame(height: 3)
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func inputBirthdateView(index: Int) -> some View {
        HStack(spacing: 0){
            VStack{
                TextField("", text: $birthday[index], onEditingChanged: { _ in
                    
                })
                .placeholder(when: birthday[index].isEmpty && field?.rawValue != index) {
                    Text(allBirthdayFields[index].playHolder)
                        .font(.montserrat(.semiBold, size: 16))
                        .foregroundColor(Color(hex: "#C1C1C1"))
                }
                .font(.montserrat(.semiBold, size: 16))
                .focused($field, equals: allBirthdayFields[index])
                .foregroundColor(Color(hex: "#C1C1C1"))
                .multilineTextAlignment(.center)
                //                    .onReceive(Just($birthday[index])) { _ in
                //
                //                    }
                .keyboardType(.numberPad)
                .onChange(of: birthday[index]) { newValue in
                    let number = Int(newValue) ?? 100
                    
                    if number <= allBirthdayFields[index].max {
                        if newValue.count >= 1 {
                            birthday[index] = String(newValue.prefix(1))
                            field = BirthdayField(rawValue: index + 1)
                        } else {
                            birthday[index] = newValue
                        }
                    } else {
                        birthday[index] = ""
                    }
                    
                    model.onAddBithday(values: birthday)
                }
                
                Rectangle()
                    .foregroundColor(field?.rawValue == index ? MyColor.red : MyColor.red.opacity(0.5))
                    .frame(height: 3)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: 14, height: 40, alignment: .center)
            
            if index == 1 || index == 3 {
                VStack{
                    Text("/")
                        .font(.montserrat(.medium, size: 15))
                        .foregroundColor(Color(hex: "#C1C1C1"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 5)
                    Spacer()
                }
                .frame(width: 12, height: 40, alignment: .center)
            }
        }
    }
    
    var selectGenderView: some View {
        VStack(spacing: 20) {
            Button {
                model.onSelectGender(.female)
            } label: {
                buildButton(with: "FEMALE")
                    .opacity(model.gender == .female ? 1 : 0.5)
            }
            
            
            Button {
                model.onSelectGender(.male)
                
            } label: {
                buildButton(with: "MALE")
                    .opacity(model.gender == .male ? 1 : 0.5)
                
            }
        }
        .frame(width: 260, alignment: .center)
        .padding(.vertical, 20)
    }
    
    var bioView: some View {
        TextField("", text: $model.bio)
            .placeholder(when: model.bio.isEmpty ) {
                Text("Type here...")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.openSans(.regular, size: 15))
                    .foregroundColor(Color(hex: "#999999"))
            }
            .font(.openSans(.semiBold, fixedSize: 15))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(hex: "#C1C1C1"))
            .padding(.horizontal, 20)
            .onChange(of: model.bio) { newValue in
                model.onBioChange(newValue)
            }
    }
    
    var selectProfileImages: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                if model.profileImageData.isEmpty {
                    EmptyView()
                } else {
                    
                    ReorderableForEach(items: model.profileImageData) { item in
                        GridSelectImageView(item: item, imagePicker: $model.imagePicker, isDelete: $model.isShowingDelete) {
                            model.profileImageId = item.id
                        }
                        .background(.red)
                    } moveAction: { from, to in
                        model.profileImageData.move(fromOffsets: from, toOffset: to)
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
                    isCameraOn = true
                    //model.isCameraOn = true
                case 1:
                    model.isFilePicker = true
                default: break
                }
                
                model.imagePicker = false
            }, options: ["Camera", "Gallery"])
        }
        .background(Color.clear)
        .ignoresSafeArea()
    }
    
    var deleteSheet : some View {
        CustomActionSheet(onSelectProfileOption: { index in
            switch index {
            case 0://delete
               
                model.onRemoveProfileImage()
            default: break
                
            }
            
            model.isShowingDelete = false
        }, options: ["Delete"])
        .ignoresSafeArea()
    }
}

