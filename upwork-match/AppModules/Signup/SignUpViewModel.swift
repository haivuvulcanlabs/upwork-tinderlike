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
//    @Published var profileImages: [UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    @Published var profileImageId: Int? = -1
    
    @Published var profileImageData: [GridImageData] = [GridImageData(id: 1, uiImage: nil), GridImageData(id: 2, uiImage: nil), GridImageData(id: 3, uiImage: nil), GridImageData(id: 4, uiImage: nil), GridImageData(id: 5, uiImage: nil), GridImageData(id: 6, uiImage: nil)] {
        didSet {
            
        }
    }
    
    @Published var isShowingDelete = false
    @Published var imagePicker = false
    @Published var categoryPicker = false
    @Published var isImagePickerOn = false
    @Published var itemType : ImagePickerType = .image
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Published var fileName = ""
    @Published var docImage = UIImage()
    @Published var isCameraOn = false
    @Published var selfie: UIImage? = UIImage()
    @Published var isFilePicker = false
    
    @Published var birthdayModel = BirthdateViewModel()
    @Published var gender: Gender?
    @Published var bio: String = ""

    @Published var isVerified = false
    @Published var errorMessage: String?
    
    func onAddBithday(values: [String]) {
        isVerified = false
        let numbers: [Int] = values.compactMap({Int($0) ?? -1})
        
        guard !numbers.contains(-1) else {
            return
        }
        
        let dateString = String(format: "%d%d/%d%d/%d%d%d%d", numbers[0],numbers[1],numbers[2],numbers[3],numbers[4],numbers[5],numbers[6],numbers[7])
        let date = dateString.toDate(format: "dd/MM/yyyy")
        let deltaTime = Date().timeIntervalSince1970 - date.timeIntervalSince1970
        guard deltaTime >= 18 * 365 * 24 * 60 * 60 else {
            errorMessage = "Minimum age requirement is 18."
            return
        }
        
        guard deltaTime < 100 * 365 * 24 * 60 * 60 else {
            errorMessage = "Maximum age requirement is 100."
            return
        }
        isVerified = true
        errorMessage = nil

        debugPrint("hai -- date \(dateString)")
    }
    
    func onNameChanged(name: String) {
        guard name.count >= 2 else {
            isVerified = false
            errorMessage = "Name must be at lest two letters."
            return
        }

        let decimalCharacters = CharacterSet.decimalDigits

        let decimalRange = name.rangeOfCharacter(from: decimalCharacters)

        if decimalRange != nil {
            isVerified = false
            errorMessage = "Please enter only letters."
            return
        }
        
        errorMessage = nil

        isVerified = true
    }
    
    func onSelectGender(_ value: Gender) {
        gender = value
        isVerified = gender != nil
    }
    
    func onBioChange(_ value: String) {
        bio = value
        isVerified = true
    }
    
    func onRemoveProfileImage() {
        guard let profileImageId = profileImageId else { return }
        profileImageData.removeAll(where: {$0.id == profileImageId})
    }
    
    func onProfileImagesChanged() {
        let images = profileImageData.filter({$0.uiImage != nil})
        
        guard images.count >= 2 else {
            isVerified = false
            return
        }
        
        isVerified = true
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

enum Gender: Int {
    case male, female
}
