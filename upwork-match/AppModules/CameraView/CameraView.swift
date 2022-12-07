/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct CameraView: View {
    @Environment(\.presentationMode) var present

    @StateObject private var model = DataModel()
 
    private static let barHeightFactor = 0.15
    @Binding var image: UIImage?
    @Binding var isActive: Bool
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                ViewfinderView(image:  $model.viewfinderImage )
                    .overlay(alignment: .top) {
                        HStack {
                            Button {
                                present.wrappedValue.dismiss()
                            } label: {
                                Asset.Assets.icCloseWhite.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                            }
                            .frame(width: 30, height: 30)
                            Spacer()
                        }
                        .frame(height: 44)
                        .padding(EdgeInsets(top: Device.topSafeArea, leading: 10, bottom: 0, trailing: 0))

                    }
                    .overlay(alignment: .bottom) {
                        buttonsView()
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                            .background(.clear)
                    }
                   
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
            }
            .task {
                await model.camera.start()
                await model.loadPhotos()
                await model.loadThumbnail()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
            .fullScreenCover(isPresented: $model.didCapturePhoto) {
//                EditPhotoView(viewfinderImage: model.capturedImage)
                PhotoCropper(profileImage: $model.profileImage) { data in
                    if let notNilData = data {
                        image = UIImage(data: notNilData)
                        withoutAnimation {
                            isActive = false
                        }
                    }
                }
            }
        }
    }
    
    private func buttonsView() -> some View {
        HStack(spacing: 60) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: Device.width/2 - 31 - 60)
         
            Button {
                model.camera.takePhoto()
            } label: {
                Circle()
                    .strokeBorder(.white, lineWidth: 2)
                    .frame(width: 52, height: 52)
            }
            
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Asset.Assets.icSwitchCamera.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
            }
            
            Spacer()
        
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    
}
