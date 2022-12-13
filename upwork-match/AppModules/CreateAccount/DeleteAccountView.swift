//
//  DeleteAccountView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct DeleteAccountView: View {
    @Environment(\.presentationMode) var present
    @State var showingDeleteAlert = false
    @State var isAccountDeleted = false
    @State var isLoading = false
    var body: some View {
        ZStack {
            VStack {
               navView
                
                Text("Account Deletion")
                    .font(.montserrat(.semiBold, size: 18))
                    .foregroundColor(Color(hex: "#CBCBCB"))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 66, leading: 0, bottom: 20, trailing: 0))
                
                Text("If you delete your account, you will lose your profile, messages, photos permanently.")
                    .font(.montserrat(.medium, size: 14))
                    .foregroundColor(Color(hex: "#ACACAC"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                Button {
                    showingDeleteAlert.toggle()
                } label: {
                    buildButton(with: "DELETE MY ACCOUNT")
                }
                
            }
            
            if showingDeleteAlert {
                CustomAlert(presentAlert: $showingDeleteAlert, alertType: .error(title: "Delete Account", message: "Are you sure you want to delete your account?"), isShowVerticalButtons: false, optionTexts: ["Cancel", "Yes"]){ index in
                    if index == 0 {
                        //do nothing
                    } else {
                        //delete account
                        self.deleteAccount()
                    }
                    withAnimation {
                        showingDeleteAlert = false
                    }
                }
            }
           
            if isAccountDeleted {
                CustomAlert(presentAlert: $isAccountDeleted, alertType: .error(title: "Account Deleted", message: "Your account was successfully deleted."), isShowVerticalButtons: false, optionTexts: ["Close"]){ index in
                    
                    withAnimation {
                        isAccountDeleted = false
                        AppFlow.shared.isLoggedIn = false
                    }
                }
            }
            
            LoaderView(isLoading: $isLoading)

        }

        .dragAndBack()
        .myBackColor()
    }
    
    var navView: some View {
        ZStack{
            HStack{
                
                Spacer()
                Text("DELETE ACCOUNT")
                    .font(.openSans(.bold, size: 12))
                    .foregroundColor(MyColor.red)
                Spacer()
            }
            .frame(width: Device.width, height: 44, alignment: .leading)
            
            HStack {
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: 5){
                        Asset.Assets.icBackRed.image.resizable().scaledToFit()
                            .frame(width: 12, height: 21)
                        Text("SETTINGS")
                            .font(.openSans(.bold, size: 12))
                            .foregroundColor(MyColor.red)
                    }
                    .padding(.horizontal, 10)
                }
            }
            .frame(width: Device.width, height: 44, alignment: .leading)
        }//nav
    }
    
    func deleteAccount() {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        
        isLoading = true
        let fbServices = FirebaseServices()
        fbServices.deleteProfile(by: user.uid)
        
        user.delete { error in
            self.isLoading = false

            if let error = error {
            // An error happened.
            } else {
            // Account deleted.
                self.isAccountDeleted = true
                AppFlow.shared.isLoggedIn = false
                
                SessionManager.shared.clear()

            }
        }
    }
}
