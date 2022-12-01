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
                            .font(.system(size: 17, weight: .black))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(height: 25)
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 16)
                    }

                    // alert message
                    Text(alertType.message())
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .minimumScaleFactor(0.5)

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
                                    .font(.system(size: 17))
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
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
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
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .success:
            return "Go"
        case .error(_, _):
            return "Go"
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .success:
            return "Cancel"
        case .error(_, _):
            return "Cancel"
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
