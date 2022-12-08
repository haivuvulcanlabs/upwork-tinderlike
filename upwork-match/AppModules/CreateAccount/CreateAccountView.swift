//
//  CreateAccountView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    @StateObject private var model = CreateAccountViewModel()
    @State private var showingBottomView: Bool = false
    @State private var scale = 1.0
    
    var body: some View {
        ZStack{
                VStack {
                    Image("ic-logo")
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
                VStack {
                    Text("By continuing, you agree with the\nPrivacy Policy and Community Guidelines.")
                        .foregroundColor(Color(hex: "CCCCCC"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20)
//                    NavigationLink {
//                        EditPhotoView()
//                    } label: {
//                        buildButton(with: "SIGN IN WITH APPLE")
//                    }
                    
                    Button {
                        withAnimation(.spring()) {
                            AppFlow.shared.isLoggedIn = true
                        }
                    } label: {
                        buildButton(with: "SIGN IN WITH APPLE")
                    }

                    
                    NavigationLink {
                        SignupView()
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
                .offset(x:  0, y: !showingBottomView ? Device.height : Device.height - 600)
                .onAppear{
                    withAnimation(.linear(duration: 1).speed(1)){
                        showingBottomView = true
                    }
                }
            }
            
        }
        
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
