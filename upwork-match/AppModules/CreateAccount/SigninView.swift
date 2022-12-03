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
    var verifyField: [VerifyCodeField] = VerifyCodeField.allCases
    @FocusState var selectedField: VerifyCodeField?
    @State var verifyCodes: [String] = ["","","","","",""]
    @State private var selectedCountry: String = ""
    @State var isShowPhonePicker = false
    var body: some View {
        
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-close-red"), text: "Sign in")
                if model.step == .inputPhone {
                    Text("Enter your mobile number")
                        .font(.montserrat(.semiBold, size: 22))
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    
                } else if model.step == .inputCode {
                    inputVerifyCodeView
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
            BottomSheet(isShowing: $isShowPhonePicker, content: AnyView(phonePicker))
        }
        .onAppear{
            isShowPhonePicker = true
        }
        .myBackColor()
    }
    
    var inputVerifyCodeView: some View {
        VStack {
            Text("Enter your code")
                .foregroundColor(Color(hex: "C1C1C1"))
                .font(.montserrat(.semiBold, size: 22))
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
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
                ForEach(0 ..< verifyCodes.count, id: \.self) { index in
                    VStack{
                        TextField("", text: $verifyCodes[index])
                            .font(.montserrat(.semiBold, size: 16))
                            .focused($selectedField, equals: verifyField[index])
                            .foregroundColor(Color(hex: "#C1C1C1"))
                            .multilineTextAlignment(.center)
                        
                            .frame(width: 14, height: 28)
                            .onChange(of: verifyCodes[index]) { newValue in
                                if newValue.count >= 1 {
                                    verifyCodes[index] = String(newValue.prefix(1))
                                    selectedField = VerifyCodeField(rawValue: index + 1)
                                } else {
                                    verifyCodes[index] = newValue
                                }
                                
                                model.onVerifyCodeChanged(verifyCodes)
                            }
                        
                        Rectangle()
                            .foregroundColor(selectedField?.rawValue == index ? MyColor.red : MyColor.red.opacity(0.5))
                            .frame(height: 3)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Text("The code you entered is invalid.")
                .foregroundColor(MyColor.red)
                .font(.system(size: 11))
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
        }
    }
    
    var phonePicker: some View {
        CountyPicker()
            .frame(width: Device.width, height: Device.height/2, alignment: .bottom)
    }
}
