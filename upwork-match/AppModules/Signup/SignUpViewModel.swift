//
//  SignUpViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    static let shared = SignUpViewModel()
    @Published var profileImages: [UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]

    @Published var profileImageData: [GridData] = ["","", "", "", "", ""].compactMap({GridData(id: Int.random(in: 0...100), thumbURL: $0)})
    
    @Published var isShowingDelete = false
    @Published var imagePicker = false
    @Published var categoryPicker = false
    @Published var isImagePickerOn = false
    @Published var itemType : ImagePickerType = .image
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Published var fileName = ""
    @Published var docImage = UIImage()
    @Published var isCameraOn = false
    @Published var selfie = UIImage()
    @Published var isFilePicker = false
    @Published var selectedGridItem: GridData = GridData(id: -1, thumbURL: "")
    
    @Published var birthdayModel = BirthdateViewModel()
    
    func onAddBithday() {
        
    }
    
}

enum SignupStep: Int, CaseIterable {
    case phone = 0, code, name, birthday, gender, bio, photo
    
    var titleText: String {
        switch self {
        case .phone:
            return ""
        case .code:
            return ""
        case .name:
            return "My first name"
        case .birthday:
            return "My birthday"
        case .gender:
            return "I´am a"
        case .bio:
            return "About me"
        case .photo:
            return "Add photos"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .photo:
            return "Add at least 2 photos to continue"
        default:
            return nil
        }
    }
}
