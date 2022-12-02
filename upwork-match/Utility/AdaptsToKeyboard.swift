//
//  AdaptsToKeyboard.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import SwiftUI
import Combine

struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                        }
                        .map { rect in
                            rect.height - geometry.safeAreaInsets.bottom
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                        }
                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}


struct BackButtonNavView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let image: Image
    var text: String? = nil
    
    var body: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12, alignment: .center)
            }
            .frame(width: 30, height: 30, alignment: .center)
            
            
            if let notNilText = text, !notNilText.isEmpty {
                Spacer()
                Text(notNilText)
                    .foregroundColor(MyColor.red)
            }
            Spacer()
        }
        .frame(height: 44, alignment: .center)
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 2)
            .overlay(Rectangle().frame(height: 3))
            .foregroundColor(MyColor.red)
    }
}
