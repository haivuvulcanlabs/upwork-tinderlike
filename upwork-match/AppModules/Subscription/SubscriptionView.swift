//
//  SubscriptionView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation
import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Recurring billing, cancel anytime. By tapping “CONTINUE”, your payment will be charged to your iTunes account, and your subscription will automatically renew for the same package length at the same price until you cancel it in settings in the iTunes store at least 24 hours prior to the end of the current period. By tapping “CONTINUE”, you agree to our Privacy Police and Terms.")
                    .font(.montserrat(.medium, size: 10))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                VStack {
                    Text("Get plus".uppercased())
                        .font(.montserrat(.semiBold, size: 17))
                        .foregroundColor(MyColor.white)
                    
                    GetPlusPageView()
                    
                    HStack(spacing: 5) {
                        ForEach(0..<3) { index in
                            IAPItemView()
                        }
                    }
                    
                    Button {
                    } label: {
                        buildButton(with: "CONTINUE")
                    }
                    
                    Button {
                    } label: {
                        Text("NO THANKS")
                            .font(.montserrat(.semiBold, size: 16))
                            .foregroundColor(Color(hex: "#8E8E8E"))
                            .frame(height: 48)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            
                    }
                }
                .background(.black)
            }
        }
    }
}


struct IAPItemView: View {
    var body: some View {
        VStack {
            Text("SAVE $50")
                .font(.montserrat(.semiBold, size: 9))
                .foregroundColor(MyColor.red)
            Text("6")
                .font(.montserrat(.semiBold, size: 30))
                .foregroundColor(MyColor.white)
            
            Text("Month")
                .font(.montserrat(.semiBold, size: 12))
                .foregroundColor(MyColor.white)
            
            Text("$16.67/month")
                .font(.montserrat(.semiBold, size: 12))
                .foregroundColor(MyColor.white)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foregroundColor(MyColor.red50)
                .padding(.horizontal, 30)
            
        }
    }
}
