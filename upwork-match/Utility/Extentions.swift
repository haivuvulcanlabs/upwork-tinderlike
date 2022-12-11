//
//  Extentions.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import Foundation
import SwiftUI
import AVFoundation

//MARK: -  View
extension View {
    func myBackColor() -> some View {
        self
            .background(MyColor.black.frame(width: Device.width, height: Device.height, alignment: .center).ignoresSafeArea())
            .navigationBarHidden(true)
    }
    
    func scaleAnimation() -> some View {
        self
            .transition(.scale(scale: 1.2))
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    func snapshot(color: Color = MyColor.whiteBGTab) -> UIImage {
        
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = UIColor(color)
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func snapshotComplition(color: Color = MyColor.whiteBGTab,complition: @escaping (UIImage)->()){
        
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = UIColor(color)
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        DispatchQueue.main.async {
            let image = renderer.image { _ in
                view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            }
            complition(image)
        }
        
    }
    
    func grayBackground() -> some View {
        self
            .padding(15)
            .background(MyColor.whiteBGTab)
            .cornerRadius(12)
    }
    
    // This function changes our View to UIView, then calls another function
    // to convert the newly-made UIView to a UIImage.
        public func asUIImage() -> UIImage {
            let controller = UIHostingController(rootView: self)
            
            controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
            UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
            
            let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
            controller.view.bounds = CGRect(origin: .zero, size: size)
            controller.view.sizeToFit()
            
    // here is the call to the function that converts UIView to UIImage: `.asUIImage()`
            let image = controller.view.asUIImage()
            controller.view.removeFromSuperview()
            return image
        }
    
    
    
}

func hideKeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
}

//MARK: -  NSNotification
extension NSNotification {
    static let isPostCoverOn = Notification.Name.init("isPostCoverOn")
    static let branch = Notification.Name.init("branch")
    static let appTerminated = Notification.Name.init("app_killed")
    static let liveEnded = Notification.Name.init("live_ended")
    static let makePost = Notification.Name.init("make_post")
    static let homeTapped = Notification.Name.init("home_tapped")
    static let logout = Notification.Name.init("logout")
    static let shouldPlay = Notification.Name.init("should_play")
}


//MARK: -  Text
extension Text {
    func lightText() -> some View {
        self
            .foregroundColor(MyColor.textLight)
            .font(.custom(MyFont.GilroyRegular, size: 12))
            .frame(width: Device.width/1.5)
            .multilineTextAlignment(.center)
    }
}

//MARK: -  String
extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.data(using: .utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as AnyObject
            return json
        } else {
            return nil
        }
    }
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
func verifyUrl(urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

extension String {
    var addUploadBaseURL : String {
        return self
    }
}
//MARK: -  Int
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        if billion >= 1.0 {
            return "\(String(format: "%.g", round(billion*10)/10)) B"
        }
        if million >= 1.0 {
            return "\(String(format: "%.g", round(million*10)/10)) M"
        }
        else if thousand >= 1.0 {
            return "\(String(format: "%.1f", round(thousand*10)/10)) K"
        }
        else {
            return "\(self)"
        }
    }
    
    
}

//MARK: -  Array
extension Array where Element: Equatable {
    
    mutating func removeEqualItems(_ item: Element) {
        self = self.filter { (currentItem: Element) -> Bool in
            return currentItem != item
        }
    }
    
    mutating func removeFirstEqualItem(_ item: Element) {
        guard var currentItem = self.first else { return }
        var index = 0
        while currentItem != item {
            index += 1
            currentItem = self[index]
        }
        self.remove(at: index)
    }
    
    mutating func addRemoveToggle(_ item: Element) {
        if self.contains(item) {
            self = self.filter { (currentItem: Element) -> Bool in
                return currentItem != item
            }
        } else {
            self.append(item)
        }
    }
}

//MARK: -  Date
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension String {
    var path: String? {
        return Bundle.main.path(forResource: self, ofType: nil)
    }
    var pathToName: String {
        return (self.components(separatedBy: "_").last ?? " ").capitalizingFirstLetter()
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func removeUnderscore() -> String {
        return (self.replacingOccurrences(of: "_", with: " "))
    }
}


extension Double {
    func convertSecondsToHMmSs()-> String {
        let s:Int = Int(self.truncatingRemainder(dividingBy: 60));
        
        let m:Int = Int((self / 60).truncatingRemainder(dividingBy: 60));
        
        let h:Int = Int(((self / 60) / 60).truncatingRemainder(dividingBy: 60));
        
        if (m >= 59) || h > 0 {
            return "\(String.init(format: "%02d:%02d", arguments: [h, m]))"
        }
        return "\(String.init(format:"%02d:%02d", m, s))"
    }
    
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
extension View {
    func tapAndHideKeyboard() -> some View {
        self.gesture(TapGesture().onEnded({ _ in
            hideKeyboard()
        }))
    }
}
extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}
extension AVURLAsset {
    var isAudioAvailable: Bool? {
        return self.tracks.filter({$0.mediaType == AVMediaType.audio}).count != 0
    }
}
extension AVPlayer {
    var isAudioAvailable: Bool? {
        return self.currentItem?.asset.tracks.filter({$0.mediaType == AVMediaType.audio}).count != 0
    }
}

extension Date {
    func toString(format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate(format: String = "dd/MM/yyyy HH:mm") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
}

func isSameDay(date1: Date, date2: Date) ->Bool{
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
}

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    var emojis: [Character] { filter { $0.isEmoji } }
    
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}

//MARK:- Drag And Back
struct DragBack: ViewModifier {
    @Environment(\.presentationMode) var present
    @GestureState private var dragOffset = CGSize.zero
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.present.wrappedValue.dismiss()
                }
            }))
    }
}

extension View {
    @ViewBuilder
    func dragAndBack(_ on: Bool = true) -> some View {
        if on {
            self.modifier(DragBack())
        } else {
            self
        }
    }
}

extension View {
    
    @ViewBuilder
    func ios16<Content: View>(
        modifier: (Self) -> Content
    ) -> some View {
        if #available(iOS 16.0, *) {
            modifier(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ios16TextEditor() -> some View {
        if #available(iOS 16.0, *) {
            //            self.scrollContentBackground(.hidden)
        } else {
            self
        }
    }
}


extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
