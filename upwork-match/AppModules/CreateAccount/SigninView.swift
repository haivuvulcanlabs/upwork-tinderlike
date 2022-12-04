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
    @State var isShowPhonePicker = false
    var countries: [Country] = CountryManager.shared.getCountries()
    
    var body: some View {
        
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-close-red"), text: "Sign in")
                if model.step == .inputPhone {
                    Text("Enter your mobile\nnumber")
                        .font(.montserrat(.semiBold, size: 22))
                        .foregroundColor(Color(hex: "C1C1C1"))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    HStack(spacing: 12){
                        Spacer()
                        VStack {
                            HStack() {
                                Text(model.selectedCountry.displayText)
                                    .font(.montserrat(.medium, size: 14))
                                    .foregroundColor(Color(hex: "999999"))
                                    .onTapGesture {
                                        isShowPhonePicker = true
                                    }
                                Asset.Assets.icDownArrow.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 10, alignment: .center)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                            
                            Rectangle()
                                .foregroundColor(MyColor.red50)
                                .frame(width: 63 * (CGFloat(model.selectedCountry.displayText.count) / 5.0),height: 2)

                        }
                        .frame(width: 63 * (CGFloat(model.selectedCountry.displayText.count) / 5.0))

                        VStack{
                            TextField("", text: $model.phoneNumber)
                                .keyboardType(.phonePad)
                                .font(.montserrat(.medium, size: 14))
                                .foregroundColor(Color(hex: "999999"))
                                .frame(width: 104)
                                .onChange(of: model.phoneNumber) { newValue in
                                    model.onPhoneNumberChanged(newValue)
                                }
                            Rectangle()
                                .foregroundColor(MyColor.red50)
                                .frame(width: 104, height: 2)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                } else if model.step == .inputCode {
                    withAnimation {
                        inputVerifyCodeView
                    }
                }
                
                
                Spacer()
                if model.step == .inputPhone {
                    
                    Text("When you tap \"Continue\", Tinder will send a text with verification code. Message and data rates may apply. The verified phone number can be used to login.")
                        .multilineTextAlignment(.center)
                        .font(.montserrat(.semiBold, size: 10))
                        .foregroundColor(Color(hex: "CCCCCC"))
                        .padding(.horizontal, 60)
                }
                
                Button {
                    model.tappedContinueButton()
                } label: {
                    
                    buildButton(with: "CONTINUE")
                        .opacity(model.isVerified ? 1 : 0.5)
                }
                .disabled(!model.isVerified)
                
            }
            .adaptsToKeyboard()
            BottomSheet(isShowing: $isShowPhonePicker, content: AnyView(phonePicker))
            .adaptsToKeyboard()

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
                    model.tappedResend()
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
                            .keyboardType(.numberPad)
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
                    .frame(width: 14, height: 40, alignment: .center)
                    
                }
            }
            
            if let errorMessage = model.errorMessage {
                Text(errorMessage)
                    .foregroundColor(MyColor.red)
                    .font(.system(size: 11))
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
            
        }
    }
    
    var phonePicker: some View {
        CountyPicker(selectedCountry: $model.selectedCountry, isShowing: $isShowPhonePicker, countries: countries)
            .frame(width: Device.width, height: Device.height/2, alignment: .bottom)
    }
}
