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
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { index in
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(index == self.currentPage ? MyColor.red : (index < currentPage ? MyColor.red.opacity(0.5) : Color(hex: "404040")))
                    .onTapGesture(perform: { self.currentPage = index })
            }
        }
    }
}
