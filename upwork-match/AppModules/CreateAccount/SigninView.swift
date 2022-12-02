//
//  SigninInputPhoneView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI

struct SigninView: View {
    @StateObject private var model = SignInViewModel()
    @State private var code: String = ""
    var body: some View {
        
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-close-red"), text: "Sign in")
                if model.step == .inputPhone {
                    Text("Enter your mobile number")
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .font(.system(size: 22, weight: .semibold))
                } else if model.step == .inputCode {
                    Text("Enter your code")
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .font(.system(size: 22, weight: .semibold))
                    HStack{
                        Text("sent to +112345678")
                            .foregroundColor(Color(hex: "C1C1C1"))
                            .font(.system(size: 10, weight: .medium))
                        Button {
                            
                        } label: {
                            Text("Resend")
                                .foregroundColor(Color(hex: "CBCBCB"))
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .padding(.vertical, 2)
                    
                    HStack(spacing: 2){
                        ForEach(0 ..< 6, id: \.self) { index in
                            VStack{
                                TextField("\(index)", text: $code)
                                    .foregroundColor(Color(hex: "C1C1C1"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 14, height: 28)

                                Rectangle()
                                    .foregroundColor(Color.red)
                                    .background(Color.red)
                                    .frame(width: 14, height: 3)
                            }
                        }
                    }
                    
                    Text("The code you entered is invalid.")
                        .foregroundColor(MyColor.red)
                        .font(.system(size: 11))
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)

                }
                
                
                Spacer()
                if model.step == .inputPhone {
                    
                    Text("When you tap \"Continue\", Tinder will send a text with verification code. Message and data rates may apply. The verified phone number can be used to login.")
                        .foregroundColor(Color(hex: "CCCCCC"))
                }
                
                Button {
                    model.tappedContinueButton()
                } label: {
                    buildButton(with: "CONTINUE")
                }
                
            }
            .adaptsToKeyboard()
        }
        .myBackColor()
    }
}
