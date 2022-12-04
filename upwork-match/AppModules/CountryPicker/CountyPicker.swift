//
//  CountyPicker.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

struct CountyPicker: View {
    let alphabet: [String] =  "abcdefghijklmnopqrstuvwxyz".compactMap { String($0) }
    
    @State var query: String = ""
    @State var filteredCountries: [String: [Country]] = [:]
    @Binding var selectedCountry: Country
    @Binding var isShowing: Bool

    var countries: [Country]
    
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
                            .foregroundColor(.white)
                            .font(.montserrat(.regular, size: 17))
                            .onChange(of: query) { newValue in
                                onTextChanged(newValue: newValue)
                            }
                    }
                    .frame(width: Device.width - 40, height: 50, alignment: .center)
                    .background(Color(hex: "767680"))
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                
                
                
                List() {
                    ForEach(0..<alphabet.count, id: \.self) { index in
                        let key = alphabet[index]
                        let _countries = filteredCountries[key] ?? []
                        if !_countries.isEmpty {
                            
                            VStack(alignment: .leading) {
                                
                                Text(key)
                                    .font(.montserrat(.semiBold, size: 12))
                                    .foregroundColor(.white)
                                    .listRowBackground(Color(hex: "181818"))
                                    .padding(.horizontal, 20)
                                
                                
                                ForEach(0..<_countries.count, id: \.self) { idx in
                                    buildRowView(country: _countries[idx])
                                }
                            }
                            .listRowBackground(Color(hex: "181818"))
                        }
                    }
                }
                .background(Color(hex: "#1F1F1F"))
                .listStyle(PlainListStyle())
            }
        }
        .task(delayText)
        .background(Color(hex: "#181818").opacity(0.94))
        .onAppear{
            
        }
    }
    
    @ViewBuilder
    func buildRowView(country: Country) -> some View {
        VStack(spacing: 0){
            Rectangle()
                .frame(width: Device.width - 40, height: 1, alignment: .center)
                .foregroundColor(Color(hex: "#5A5A5A"))
            HStack{
                Text(country.localizedName)
                    .font(.montserrat(.semiBold, size: 12))
                    .foregroundColor(.white)
                Spacer()
                Text(country.phoneCode)
                    .font(.montserrat(.semiBold, size: 12))
                    .foregroundColor(.white)
            }
            .frame(height: 38)
            .padding(.horizontal, 20)
            .listRowBackground(Color.black)
            .onTapGesture {
                selectedCountry = country
                isShowing = false
            }
        }
        .listRowBackground(Color(hex: "181818"))
        
    }
    
    private func delayText() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: 100_000_000)
        groupCountries(with: countries)
    }
    
    func groupCountries(with countries: [Country]) {
        for char in alphabet {
            self.filteredCountries[char] = countries.filter({$0.localizedName.lowercased().starts(with: char)})
        }
    }
    
    func onTextChanged(newValue: String) {
        if newValue.isEmpty {
            
            groupCountries(with: countries)
            
        } else {
            
            let _countries = countries.filter({$0.localizedName.contains(newValue)})
            
            groupCountries(with: _countries)
            
        }
    }
}
