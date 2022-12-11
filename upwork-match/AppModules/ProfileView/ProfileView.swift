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
                    .font(.roboto(.black, size: 17))
                    .foregroundColor(MyColor.red)
                Spacer()
            }
            Image("ic-thumb-1")
                .resizable()
                .scaledToFill()
                .frame(width: Device.width * 180.0 / 375.0, height:  Device.width * 180.0 / 375.0, alignment: .center)
                .clipShape(Circle())
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            
            
            Text("Jhon, 22")
                .font(.montserrat(.semiBold, size: 25))
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
            
            GetPlusPageView()
            
            NavigationLink(destination: MyPlusView()) {
                
                Text("Get plus".uppercased())
                    .font(.montserrat(.semiBold, size: 16))
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
    var font: Font = .openSans(.bold, size: 15)
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
    struct PlusText {
        let icon: Image
        let title: String
        let subTitle: String
    }
    var plusTexts: [PlusText] = []
    
    init() {
        let text1 = PlusText(icon: Asset.Assets.icDoubleChat.image, title: "Unlimited message", subTitle: "Send as many messages you want")
        let text2 = PlusText(icon: Asset.Assets.icHeart.image, title: "Unlimited likes", subTitle: "Like as much you want")
        let text3 = PlusText(icon: Asset.Assets.icAds.image, title: "Turn off adverts", subTitle: "Don´t get disturbed")
        plusTexts = [text1, text2, text3]
    }
    
    var body: some View {
        TabView {
            ForEach(0..<plusTexts.count, id: \.self) { i in
                let plusText = plusTexts[i]
                ZStack {
                    MyColor.darkBG
                    VStack{
                        plusText.icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                        Text(plusText.title)
                            .foregroundColor(.white)
                            .font(.montserrat(.semiBold, size: 14))
                            .padding(.vertical, 1)
                        Text(plusText.subTitle)
                            .foregroundColor(.white)
                            .font(.montserrat(.medium, size: 12))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    }
                }
            }
        }
        .background(Color.black)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(width: UIScreen.main.bounds.width, height: 150)
        .padding(.vertical, 10)
    }
}
