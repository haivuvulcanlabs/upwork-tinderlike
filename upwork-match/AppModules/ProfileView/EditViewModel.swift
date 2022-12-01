//
//  EditViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI

class EditViewModel: ObservableObject {
    @Published var isShowingDelete = false
    @Published var imagePicker = false
    @Published var categoryPicker = false
    @Published var isImagePickerOn = false
    @Published var itemType : ImagePickerType = .image
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

}
