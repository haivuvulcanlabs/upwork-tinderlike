//
//  CreateAccountView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    @StateObject private var model = CreateAccountViewModel()
    @State private var showingBottomView: Bool = false
    @State private var scale = 1.0
    @State private var menuViewH: CGFloat = 400
    var body: some View {
        ZStack{
            NavigationLink(isActive: $model.isActiveSignup) {
                SignupView()
            } label: {
                
            }

                VStack {
                    Asset.Assets.icLogo.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80 * scale, height: 80 * scale, alignment: .center)
//                        .scaleEffect(scale)
//                        .animation(.linear(duration: 1), value: scale)
                        .animation(.easeInOut(duration: 1), value: scale)

//                        .offset(x: 0, y: Device.height/3 - (80 * scale) / 2 )
                    
                        .offset(x: 0, y: Device.height/3 - (80 * scale) / 2 )
                        .onAppear {
                            scale = 2.5
                        }
                    Spacer()
                }
            
                VStack {
                    Text("By continuing, you agree with the\nPrivacy Policy and Community Guidelines.")
                        .foregroundColor(Color(hex: "CCCCCC"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20)
                    Button {
                        model.signInWithApple()
                    } label: {
                        buildButton(with: "SIGN IN WITH APPLE")
                    }

                    NavigationLink {
                        SignInView(isLoginFlow: false)
                    } label: {
                        buildButton(with: "CREATE ACCOUNT")
                    }
                    .padding(.vertical, 15)
                    
                    NavigationLink {
                        SignInView()
                    } label: {
                        buildButton(with: "SIGN IN")
                    }
                    
                    Divider()
                        .frame(height: Device.bottomSafeArea)
                }
                .offset(x:  0, y: !showingBottomView ? Device.height : Device.height - (Device.hasTopNoth ? 580 : 500) - Device.bottomSafeArea)
                .onAppear{
                    withAnimation(.linear(duration: 1).speed(1)){
                        
                        showingBottomView = true
                    }
            }
        }
        .ignoresSafeArea(.all)
        .myBackColor()
    }
}

extension View {
    @ViewBuilder
    func buildButton(with text: String) -> some View {
        Text(text)
            .font(.montserrat(.semiBold, size: 16))
            .foregroundColor(MyColor.red)
            .frame(height: 48)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 30)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(lineWidth: 2)
                    .foregroundColor(MyColor.red)
                    .padding(.horizontal, 30)
                
            }
    }
}
