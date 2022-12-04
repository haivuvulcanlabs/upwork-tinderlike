//
//  CustomAlert.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import SwiftUI

struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .success
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    var optionTexts: [String] = []

    var leftButtonAction: ((Int) -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    presentAlert.toggle()
                }
            VStack(spacing: 0) {

                    if alertType.title() != "" {

                        // alert title
                        Text(alertType.title())
                            .font(.roboto(.black, size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(height: 22)
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 16)
                    }

                    // alert message
                    Text(alertType.message())
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .font(.roboto(.regular, size: 13))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)

                    Divider()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                        .padding(.all, 0)
                
                
                if !isShowVerticalButtons {
                    HStack(spacing: 0) {

                        ForEach(0..<optionTexts.count,id: \.self) { index in
                            Button {
                                leftButtonAction?(index)
                            } label: {
                                Text(optionTexts[index])
                                    .font(.roboto(.regular, size: 17))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            .frame(height: 44)
                        }

                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)

                } else {
                    VStack(spacing: 0) {
                       
                        ForEach(0..<optionTexts.count,id: \.self) { index in
                            Button {
                                leftButtonAction?(index)
                            } label: {
                                Text(optionTexts[index])
                                    .font(.roboto(.regular, size: 17))
                                    .foregroundColor(Asset.Colors.hex0A84FF.color)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            .frame(height: 44)
                        }
                    }
                }

                }
                .frame(width: 270, height: alertType.height(isShowVerticalButtons: isShowVerticalButtons))
                .background(
                    MyColor.popupBackground
                )
                .cornerRadius(14)
            
        }
        .animation(.easeInOut, value: presentAlert)        
    }
}


enum AlertType {
    
    case success
    case error(title: String, message: String = "")
    
    func title() -> String {
        switch self {
        case .success:
            return "Success"
        case .error(title: let title, _):
            return title
        }
    }

    func message() -> String {
        switch self {
        case .success:
            return "Please confirm that you're still open to session requests"
        case .error(_, message: let message):
            return message
        }
    }


    
    func height(isShowVerticalButtons: Bool = false) -> CGFloat {
        switch self {
        case .success:
            return isShowVerticalButtons ? 220 : 150
        case .error(_, _):
            return isShowVerticalButtons ? 220 : 150
        }
    }
}
