//
//  SubscriptionView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation
import SwiftUI

struct SubscriptionView: View {
    @StateObject var model = PurchaseViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Recurring billing, cancel anytime. By tapping “CONTINUE”, your payment will be charged to your iTunes account, and your subscription will automatically renew for the same package length at the same price until you cancel it in settings in the iTunes store at least 24 hours prior to the end of the current period. By tapping “CONTINUE”, you agree to our Privacy Police and Terms.")
                    .font(.montserrat(.medium, size: 10))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                
                VStack {
                    Text("Get plus".uppercased())
                        .font(.montserrat(.semiBold, size: 17))
                        .foregroundColor(MyColor.white)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))

                    
                    GetPlusPageView()
                    
                    HStack(spacing: 8) {
                        ForEach(0..<model.items.count, id: \.self) { index in
                            let item =  model.items[index]
                            let selected = item.product.productIdentifier == model.selectedItem?.product.productIdentifier
                            
                            IAPItemView(item: item, isSelected: selected)
                                .onTapGesture {
                                    model.onSelectItem(item)
                                }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    Button {
                        model.onPurchased(item: model.selectedItem) { status in
                            
                        }
                    } label: {
                        buildButton(with: "CONTINUE")
                    }
                    .disabled(model.selectedItem == nil)
                    
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
        .onAppear {
            model.getCoinPlans()
        }
    }
}


struct IAPItemView: View {
    let item: StoreItem
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
           

            HStack {
                Text(item.config.title ?? "")
                    .font(.montserrat(.semiBold, size: 9))
                    .foregroundColor(item.promoted ? Color.white : MyColor.red)
//                    .frame(width: (Device.width - 15 * 4)/3, height: 30)
            }
            .frame(height: 26, alignment: .center)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(item.promoted ? Color.red : Color.clear)

            Text("\(item.config.duration)")
                .font(.montserrat(.semiBold, size: 30))
                .foregroundColor(MyColor.white)
                .padding(.vertical, 8)
            
            Text(item.config.durationText)
                .font(.montserrat(.semiBold, size: 12))
                .foregroundColor(MyColor.white)
            
            Text("\(item.product.price)/month")
                .font(.montserrat(.semiBold, size: 12))
                .foregroundColor(MyColor.white)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 8, trailing: 0))
        }
        .frame(width: (Device.width - 15 * 4)/3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
                .foregroundColor(isSelected ? MyColor.red : MyColor.red50)
                .clipped()
        }
    }
}
