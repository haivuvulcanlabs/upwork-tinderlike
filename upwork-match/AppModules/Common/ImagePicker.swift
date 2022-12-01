//
//  ImagePicker.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import SwiftUI
/// Import this class in your file

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var image : UIImage
    @Binding var filename : String
    var imagePickerType : UIImagePickerController.SourceType = .photoLibrary
    @Binding var videoURL : URL
    var type : ImagePickerType = .image
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent : ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage{
                let  url = info[.imageURL] as? URL
                parent.filename = String(url?.absoluteString.split(separator: "/").last ?? "").removingPercentEncoding ?? ""
                parent.image = uiImage
            }
            if let movieUrl = info[.mediaURL] as? URL  { parent.videoURL = movieUrl }
            
            picker.dismiss(animated: true)
        }

    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = imagePickerType
        
        if type == .video {
            picker.mediaTypes = ["public.movie"]
        }
        if imagePickerType == .camera {
            picker.cameraDevice = .front
        }
        
//        picker.cameraCaptureMode = .photo
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
   
}
//MARK: AND Bind UIIMAGE variable in sheet
enum ImagePickerType {
    case video
    case image
}

struct VideoPicker : UIViewControllerRepresentable {
    @Binding var videoURL : URL?
    var type : ImagePickerType = .video
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent : VideoPicker
        
        init(_ parent: VideoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let movieUrl = info[.mediaURL] as? URL  {
                
                let exe = movieUrl.absoluteString.components(separatedBy: ".").last ?? "mp4"
                // *** load video data from URL *** //
                let videoData = try? Data(contentsOf: movieUrl)
                let path = Functions.getDocumentsDirectory().appendingPathComponent("picker_video.\(exe)")
                
                parent.videoURL = path
                // *** Write video file data to path *** //
                do {
                    try videoData?.write(to: path)
                } catch let err {
                    print(err.localizedDescription)
                }
            }
            
            picker.dismiss(animated: true)
        }

    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = sourceType
        if type == .video {
            picker.mediaTypes = ["public.movie"]
        }
//        picker.cameraCaptureMode = .photo
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
   
}
