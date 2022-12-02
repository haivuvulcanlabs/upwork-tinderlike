//
//  WellcomeView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI

struct WellcomeView: View {
    var body: some View {
        
        ZStack() {
            VStack(spacing: 40){
                //
                wellcomeView
                yourSelfView
                staySafe
                playCoolView
                proactiveView
                
                Spacer()
                Button {
                } label: {
                    buildButton(with: "CONTINUE")
                }
            }
            .padding(.horizontal, 14)
        }
        .myBackColor()
    }
    
    var wellcomeView: some View {
        VStack(spacing: 5){
            Image("ic-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35, alignment: .center)
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 10, trailing: 0))
            
            Text("Welcome to name!")
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 20, weight: .bold))
            Text("Please follow these House Rules.")
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 15, weight: .semibold))
        }
    }
    var yourSelfView: some View {
        VStack(spacing: 5){
            Text("Be yourself.")
                .foregroundColor(MyColor.red)
                .font(.system(size: 15, weight: .bold))
            Text("Make sure your photos, age, and bio are true to who you are.")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 15, weight: .semibold))
        }
        
    }
    
    var staySafe: some View {
        VStack(spacing: 5){
            Text("Stay safe")
                .foregroundColor(MyColor.red)
                .font(.system(size: 15, weight: .bold))
            Text("Don´t be too quick to give out personal information.")
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 15, weight: .semibold))
        }
    }
    
    var playCoolView: some View {
        VStack(spacing: 5){
            Text("Play it cool")
                .foregroundColor(MyColor.red)
                .font(.system(size: 15, weight: .bold))
            Text("Respect others and treat them as you would like to be treated.")
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 15, weight: .semibold))
        }
    }
    
    var proactiveView: some View {
        VStack(spacing: 5){
            Text("Be proactive")
                .foregroundColor(MyColor.red)
                .font(.system(size: 15, weight: .bold))
            Text("Always report bad behavior.")
                .multilineTextAlignment(.center)
                .foregroundColor(MyColor.hexD1D1D1)
                .font(.system(size: 15, weight: .semibold))
            
        }
    }
}
