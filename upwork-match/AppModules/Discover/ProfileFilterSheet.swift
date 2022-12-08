//
//  OnlineBottomSheet.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import SwiftUI

struct ProfileFilterSheet: View{
    @State private var distance: Double = 0
    @State private var minDistance: Double = 0
    @State private var maxDistance: Double = 1

    @State private var age: Double = 0
    @State private var maxAge: Double = 0.5

    @State private var minxAge: Double = 0
    @State private var maxxAge: Double = 1

    let buttonHeight: CGFloat = 55
    @State private var nob1X: CGFloat = -54
    @State private var nob2X: CGFloat = 24

    @State private var isEnded = false
    @GestureState private var isDragging = false




    var body: some View{
        VStack(alignment: .center, spacing: 0) {
            Asset.Assets.icDrawer.image
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 5, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                .clipped()
            
            
            Text("FILTER")
                .font(.openSans(.bold, size: 20))
                .foregroundColor(MyColor.textGray)
                .padding(.vertical, 5)
            HStack{
                Text("DISTANCE")
                    .font(.openSans(.bold, size: 15))
                    .foregroundColor(MyColor.textGray)
                
                Spacer()
                Text("80 KM")
                    .font(.openSans(.bold, size: 15))
                    .foregroundColor(MyColor.textGray)
                    .font(.system(size: 15, weight: .bold))
            }
            .frame(height: 20, alignment: .center)
            .padding(.vertical, 15)
            
            SwiftUISlider(
                thumbColor: UIColor(MyColor.sliderThumbColor),
                minTrackColor: UIColor(MyColor.red)  ,
                maxTrackColor: UIColor(MyColor.sliderMaxColor),
                value: $distance,
                minValue: $minDistance,
                maxValue: $maxDistance
            )
            
            HStack{
                Text("AGE")
                    .font(.openSans(.bold, size: 15))
                    .foregroundColor(MyColor.textGray)
                Spacer()
                Text("18 - 28")
                    .font(.openSans(.bold, size: 15))
                    .foregroundColor(MyColor.textGray)
            }
            .frame(height: 20, alignment: .center)
            .padding(.vertical, 5)
            
     
//                    SwiftUISlider(
//                        thumbColor: UIColor(MyColor.sliderThumbColor),
//                        minTrackColor: UIColor(MyColor.sliderMaxColor),
//                        maxTrackColor: UIColor(MyColor.red),
//                        value: $age,
//                        minValue: $minxAge,
//                        maxValue: $maxAge
//                    )

            
//            GeometryReader { geo in
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(MyColor.sliderMaxColor)
                        .frame(height: 4)
//                    HStack {
                        Rectangle()
                            .foregroundColor(MyColor.red)
                            .offset(x: nob1X + (nob2X - nob1X)/2, y: 0)
                            .frame(width: nob2X - nob1X, height: 4)
//                    }
                   
                    Circle()
                        .foregroundColor(MyColor.sliderThumbColor)
                        .frame(width: 28, height: 28)
                        .offset(x: nob1X, y: 0)
                        .gesture(DragGesture().onChanged({ value in
                            if value.location.x <= self.nob2X - 14{
                                self.nob1X = value.location.x
                            }
                        }).updating($isDragging, body: { (value, state, trans) in
                            state = true
                        }))
                    
                    Circle()
                        .foregroundColor(MyColor.sliderThumbColor)
                        .frame(width: 28, height: 28)
                        .offset(x: nob2X, y: 0)
                        .gesture(DragGesture().onChanged({ value in
                            if value.location.x >= nob1X + 14, value.location.x < Device.width/2 - 28{
                                self.nob2X = value.location.x
                            }
                        }).updating($isDragging, body: { (value, state, trans) in
                            state = true
                        }))
                }

            Button {
                
            } label: {
                Text("DONE")
                    .font(.montserrat(.semiBold, size: 16))
                    .foregroundColor(.red)
            }
            .frame(width: Device.width * 325.0 / 414.0, height: 48, alignment: .center)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(lineWidth: 2)
                    .foregroundColor(MyColor.red)
            })
            .padding(EdgeInsets(top: 25, leading: 0, bottom: 10, trailing: 0))
            
            
        }
        .padding(.horizontal, 16)
        .background(Color.black)
    }
}
