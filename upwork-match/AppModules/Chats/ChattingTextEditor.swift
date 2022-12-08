//
//  ChattingTextEditor.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 08/12/2022.
//

import SwiftUI
import GrowingTextView

struct ChattingTextEditor: View {
    var placeholder : String
    @Binding var text : String
    @State var height : CGFloat = 33
    var color = Color.white
    var body: some View {
        ZStack {
            MyTextView(placeholder: placeholder, text: $text, height: $height,color: color)
                .frame(height: height)
                .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
        }
    }
}

struct MyTextView : UIViewRepresentable {
    var placeholder : String
    @Binding var text: String
    @Binding var height : CGFloat
    var color : Color
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator : NSObject,GrowingTextViewDelegate {
        var parent : MyTextView
        init(parent: MyTextView) {
            self.parent = parent
        }
        
        func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
            parent.height = height
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async { [self] in
                self.parent.text = textView.text ?? ""
            }
        }
        @objc
        func doneButtonAction() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func makeUIView(context: Context) -> some GrowingTextView {
        let textView = GrowingTextView()
//        MARK: Adding Toolbar to Keyboard
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
//
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: context.coordinator, action: #selector(context.coordinator.doneButtonAction))
//
//        let items = NSMutableArray()
//        items.add(flexSpace)
//        items.add(done)
//
//        doneToolbar.items = items as? [UIBarButtonItem]
//        doneToolbar.sizeToFit()
//        textView.inputAccessoryView = doneToolbar
        
        
        textView.delegate = context.coordinator
        
        textView.trimWhiteSpaceWhenEndEditing = false
        textView.placeholder = placeholder
        textView.font = UIFont(name: "Roboto-Regular", size: 15)
        textView.placeholderColor = UIColor(Color(hex: "777777"))
        textView.textColor = UIColor(color)
        textView.minHeight = 33
        textView.maxHeight = 95.0
        textView.backgroundColor = .clear
//        textView.layer.cornerRadius = 4.0
        
        
        return textView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}
