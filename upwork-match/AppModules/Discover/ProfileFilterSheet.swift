//
//  OnlineBottomSheet.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import SwiftUI

struct ProfileFilterSheet: View{
    @State private var distance: Double = 0
    @State private var age: Double = 0

    let buttonHeight: CGFloat = 55
    
    var body: some View{
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text("FILTER")
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 20, weight: .bold))

                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 4)
            
            HStack{
                Text("DISTANCE")
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Text("80 KM")
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 15, weight: .bold))
            }
            .frame(height: 20, alignment: .center)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            SwiftUISlider(
                    thumbColor: UIColor(MyColor.sliderThumbColor),
                    minTrackColor: UIColor(MyColor.red)  ,
                    maxTrackColor: UIColor(MyColor.sliderMaxColor),
                    value: $distance
                 )
            
            HStack{
                Text("AGE")
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Text("18 - 28")
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 15, weight: .bold))
            }
            .frame(height: 20, alignment: .center)
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))

            SwiftUISlider(
                    thumbColor: UIColor(MyColor.sliderThumbColor),
                    minTrackColor: UIColor(MyColor.red)  ,
                    maxTrackColor: UIColor(MyColor.sliderMaxColor),
                    value: $age
                 )
            
            Button {
                
            } label: {
                Text("DONE")
                    .foregroundColor(.red)
            }
            .frame(width: Device.width * 325.0 / 414.0, height: 48, alignment: .center)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.red)
            })
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 20, trailing: 0))

            
        }
        .padding(.horizontal, 16)
        .background(Color.black)
    }
}
