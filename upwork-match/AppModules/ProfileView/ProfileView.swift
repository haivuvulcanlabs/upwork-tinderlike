//
//  ProfileView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @State var selectedTab = 0
    @State var isCreateGroupChat = false
    @State var isActive : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Profile")
                    .foregroundColor(MyColor.red)
                Spacer()
            }
            Image("ic-thumb-1")
                .resizable()
                .scaledToFill()
                .frame(width: Device.width * 180.0 / 375.0, height:  Device.width * 180.0 / 375.0, alignment: .center)
                .clipShape(Circle())
            
            
            
            Text("Jhon, 22")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(MyColor.white)
                .frame(alignment: .center)
                .padding(.vertical, 10)
            HStack{
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    VerticleButton(image: Image("ic-setting"), text: "SETTINGS")
                }
                Spacer()
                NavigationLink(destination: EditProfileView()) {
                    VerticleButton(image: Image("ic-edit-profile"), text: "EDIT PROFILE")
                }
                Spacer()
            }
            Spacer()
            
            ScrollView{
                LazyHStack {
                    GetPlusPageView()
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            
            NavigationLink(destination: MyPlusView()) {
                
                Text("Get plus")
                    .foregroundColor(MyColor.red)
                
                    .frame(width: Device.width * 325.0 / 414.0, height: 48, alignment: .center)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.red)
                    })
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
            
            
        }
        .myBackColor()
    }
}


struct VerticleButton: View {
    let image: Image
    let text: String
    let imageSize: CGFloat = 30
    var body: some View {
        VStack{
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize, alignment: .center)
            Text(text)
                .font(Font.system(size: 15, weight: .bold))
                .foregroundColor(MyColor.white)
                .frame(alignment: .center)
            
        }
    }
}


struct GetPlusPageView: View {
    var body: some View {
        TabView {
            ForEach(0..<3) { i in
                ZStack {
                    MyColor.darkBG
                    VStack{
                        Image("ic-heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                        Text("Unlimited message")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 1)
                        Text("Send as many messages you want")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .medium))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 150)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}
