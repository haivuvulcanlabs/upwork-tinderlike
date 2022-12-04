//
//  PageControl.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI

struct PageControl: View {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    var currentColor: Color = MyColor.red
    var tintColor: Color = Color(hex: "404040")
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { index in
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(index == self.currentPage ? currentColor : (index < currentPage ? currentColor.opacity(0.5) : tintColor))
                    .onTapGesture(perform: { self.currentPage = index })
            }
        }
    }
}
