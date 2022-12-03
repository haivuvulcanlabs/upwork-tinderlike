//
//  CountyPicker.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

struct CountyPicker: View {
    @State var query: String = ""
    @State var countries: [Country] = []
    @State var filteredCountries: [Country] = []
    @State var selectedCountry: Country?
    
    init() {
        countries = CountryManager.shared.getCountries()
        filteredCountries = countries
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack{
                    Spacer()
                    Asset.Assets.icDrawer.image
                        .resizable()
                        .scaledToFit()
                        .background(Color(hex: "484848"))
                        .frame(width: 42, height: 6)
                }
                .frame(height: 15)
                Text("Select country code")
                    .multilineTextAlignment(.center)
                    .font(.montserrat(.semiBold, size: 17))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
              
                HStack {
                    Spacer()
                    HStack {
                        Asset.Assets.icSearch.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.horizontal, 5)
                        TextField("", text: $query)
                            .placeholder(when: query.isEmpty, placeholder: {
                                Text("Search")
                                    .font(.montserrat(.regular, size: 17))
                                    .foregroundColor(Color(hex: "999999"))
                            })
                            .font(.montserrat(.regular, size: 17))
                            .onChange(of: query) { newValue in
                                if newValue.isEmpty {
                                    filteredCountries = countries
                                } else {
                                    filteredCountries = countries.filter({$0.localizedName.contains(newValue)})
                                }
                            }
                    }
                    .frame(width: Device.width - 40, height: 50, alignment: .center)
                    .background(Color(hex: "767680"))
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                

                
                ScrollView {
                    ForEach(0..<filteredCountries.count, id: \.self) { index in
                        VStack(spacing: 0){
                            Rectangle()
                                .frame(width: Device.width - 40, height: 1, alignment: .center)
                                .foregroundColor(Color(hex: "#5A5A5A"))
                            HStack{
                                Text(filteredCountries[index].localizedName)
                                    .font(.montserrat(.semiBold, size: 12))
                                    .foregroundColor(.white)
                                Spacer()
                                Text(filteredCountries[index].phoneCode)
                                    .font(.montserrat(.semiBold, size: 12))
                                    .foregroundColor(.white)
                            }
                            .frame(height: 38)
                            .padding(.horizontal, 20)
                            .listRowBackground(Color.black)
                            .onTapGesture {
                                selectedCountry = filteredCountries[index]
                            }
                        }
                       
                    }
                }
                .background(Color(hex: "#1F1F1F"))
                .listStyle(PlainListStyle())
            }
        }
        .background(Color(hex: "#181818").opacity(0.94))
        .onAppear{
            if countries.isEmpty {
                countries = CountryManager.shared.getCountries()
                filteredCountries = countries
            }
        }
    }
}
