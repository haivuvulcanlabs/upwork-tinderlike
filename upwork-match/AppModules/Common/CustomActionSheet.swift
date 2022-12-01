//
//  CustomActionSheet.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import SwiftUI

struct CustomActionSheet: View {
    var onSelectProfileOption: ((Int) -> Void)?
    var options: [String]
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ForEach(0..<options.count,id: \.self) { index in
                    
                    Button {
                        onSelectProfileOption?(index)
                    } label: {
                        Text(options[index])
                            .foregroundColor(.red)
                            .background(Color(hex: "#252525"))
                            .frame(height: 60, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color(hex: "#252525"))
                    
                    Divider()
                }
            }
            .cornerRadius(13, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
            
            
            
            Divider()
                .background(Color.clear)
                .foregroundColor(.clear)
                .frame(height: 10)
            
            Button {
                onSelectProfileOption?(-1)
                
            } label: {
                Text("Cancel")
                    .foregroundColor(.white)
                    .background(Color(hex: "#252525"))
                    .frame(height: 60, alignment: .center)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color(hex: "#252525"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .cornerRadius(13, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
            
            Rectangle()
                .background(Color.clear)
                .foregroundColor(.clear)
                .frame(height: Device.bottomSafeArea)
        }
        .background(Color.clear)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity)
    }
}
