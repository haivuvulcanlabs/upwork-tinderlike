//
//  Constant.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//


import SwiftUI
import Combine
import StoreKit

//MARK: Term & Privacy
struct TermsPrivacyURL {
    static var terms                    = WebServices.baseURL + "termsOfUse"
    static var privacy                     = WebServices.baseURL + "privacypolicy"
}

struct ThirdPartyLibraryData {
    static let FirebaseNotificationURL          = "https://fcm.googleapis.com/fcm/send"
    static let FirebaseNotificationKey          = "key=AAAATDiZ4MA:APA91bFzprlaDp-Yv6t9Ep9pJz1Eki0zYjFqGsKr_b8Lpxta14VgVBvPvqURdjn_vbdz5W5cGaUqS70orH1QjdT9_y7lFXnwmqb6tPyfyNZ9ntBcAnVN3AtWSgR4PaeadI_Y5MRUXKBV"
    static let FirebaseNotificationContentType  = "application/json"
    
    static let deepARLicenseKey                    = ""
    static let AWS_AccessKey                    = "AKIARDBULK4ZMMSJIC6G"
    static let AWS_SecretKey                    = "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"
    static let AWS_BucketName                   = "iwanderlust-app-bucket"
    
    static let branch_user_id                    = "user_id"
    static let branch_post_id                    = "post_id"
}

struct AllStaticData {
    static var userID = 0
    static var purchaseStorkit            = [SKProduct]()
}


//MARK: Webservice
struct WebServices {
    static let baseURL                    = "https://min.iwanderlust.app/"
    static let apiBaseURL               = baseURL + "api/"
    static let uploadBaseURL            = "https://d16avsxkmj2o8b.cloudfront.net/"
    
    static let registration                = apiBaseURL + "registration"
    static let fetchPosts                = apiBaseURL + "fetchPosts"
    static let fetchSettings            = apiBaseURL + "fetchSettings"
    static let followUser                = apiBaseURL + "followUser"
    static let unfollowUser                = apiBaseURL + "unfollowUser"
    static let fetchUserPosts            = apiBaseURL + "fetchUserPosts"
    static let fetchUserLikedPosts        = apiBaseURL + "fetchUserLikedPosts"
    static let dislikePost                = apiBaseURL + "dislikePost"
    static let likePost                    = apiBaseURL + "likePost"
    static let fetchPostsBySound        = apiBaseURL + "fetchPostsBySound"
    static let fetchExploreData            = apiBaseURL + "fetchExploreData"
    static let fetchProfileCategories    = apiBaseURL + "fetchProfileCategories"
    static let fetchPostsByHashtag        = apiBaseURL + "fetchPostsByHashtag"
    static let searchUser                = apiBaseURL + "searchUser"
    static let searchPosts                = apiBaseURL + "searchPosts"
    static let updateUserDetails        = apiBaseURL + "updateUserDetails"
    static let checkForUsername            = apiBaseURL + "checkForUsername"
    static let fetchUserDetails            = apiBaseURL + "fetchUserDetails"
    static let fetchMyUserDetails        = apiBaseURL + "fetchMyUserDetails"
    static let fetchCoinPlans            = apiBaseURL + "fetchCoinPlans"
    static let addCoinsToUserWallet        = apiBaseURL + "addCoinsToUserWallet"
    static let minusCoinsFromUserWallet = apiBaseURL + "minusCoinsFromUserWallet"
    static let submitRedeem                = apiBaseURL + "submitRedeem"
    static let applyForVerification        = apiBaseURL + "applyForVerification"
    static let fetchPostComments        = apiBaseURL + "fetchPostComments"
    static let deleteComment            = apiBaseURL + "deleteComment"
    static let addCommentOnPost            = apiBaseURL + "addCommentOnPost"
    static let fetchSoundCategories        = apiBaseURL + "fetchSoundCategories"
    static let fetchFavouriteSound        = apiBaseURL + "fetchFavouriteSound"
    static let updateFavouriteSound        = apiBaseURL + "updateFavouriteSound"
    static let fetchUserNotification    = apiBaseURL + "fetchUserNotification"
    static let fetchAdminNotification    = apiBaseURL + "fetchAdminNotification"
    static let reportPost                = apiBaseURL + "reportPost"
    static let reportUser                = apiBaseURL + "reportUser"
    static let updateUserBlockList        = apiBaseURL + "updateUserBlockList"
    static let uploadPost                = apiBaseURL + "uploadPost"
    static let fetchFollowingPosts        = apiBaseURL + "fetchFollowingPosts"
    static let fetchPopularUsersPost    = apiBaseURL + "fetchPopularUsersPost"
    static let fetchPostById            = apiBaseURL + "fetchPostById"
    static let applyForLivestream        = apiBaseURL + "applyForLivestream"
    static let generateAgoraToken        = apiBaseURL + "generateAgoraToken"
    static let fetchPostsByProfileCategory = apiBaseURL + "fetchPostsByProfileCategory"
    static let fetchProfilesByCategory  = apiBaseURL + "fetchProfilesByCategory"
    static let fetchBlockedUsers        = apiBaseURL + "fetchBlockedUsers"
    static let deletePost                = apiBaseURL + "deletePost"
    static let increasePostView            = apiBaseURL + "increasePostView"
    static let fetchFollowingList        = apiBaseURL + "fetchFollowingList"
    static let fetchFollowersList        = apiBaseURL + "fetchFollowersList"
    static let deleteMyAccount            = apiBaseURL + "deleteMyAccount"
    static let fetchAds                    = apiBaseURL + "fetchAds"
    static let increaseAdView            = apiBaseURL + "increaseAdView"
    static let increaseAdClick            = apiBaseURL + "increaseAdClick"
    static let logout                   = apiBaseURL + "logOut"
    
    static let appName                     = "ThumbsUp"
    static let gift                        = "ThumbsUps"
    
    static var currency                    = "$"
    
    
    static let HeaderKey                = "apikey"
    static let HeaderValue                = "123"
    static let AuthHeaderKey            = "AUTHTOKEN"
    
    static let notificationTopic         = "thumbsup"
    
    static var notificationToken        = ""
    
    static func getUploadingURL(fileName: String) -> String {
        return "uploads/\(fileName)"
    }
}


struct Limits {
    static let postDescriptionLimit        = 80
    static let bioLimits                = 80
    static let pagination                = 30
    static let minimumVideoLength        = 14 // in Sec
    static let unAnsweredTime           = 30
    static let maximumVideoDuration : Double = 30
    static let maximumVideoSize         = 20
    static let loadingTime: TimeInterval = 0
    static let adsAfterPost             = 10
}

//MARK: Device Size
struct Device {
    static let topSafeArea = getTopSafeArea()
    static let bottomSafeArea = getBottomSafeArea()
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.height
    
    
    static func getTopSafeArea() -> CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets.top
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
        }
    }
    static func getBottomSafeArea() -> CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets.bottom
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        }
    }
}



//MARK: Custom Font
struct MyFont {
    static var GilroyBlack                        = "Gilroy-Black"
    static var GilroyBold                        = "Gilroy-Bold"
    static var GilroyExtraBold                    = "Gilroy-ExtraBold"
    static var GilroyHeavy                        = "Gilroy-Heavy"
    static var GilroyLight                        = "Gilroy-Light"
    static var GilroyMedium                        = "Gilroy-Medium"
    static var GilroyRegular                    = "Gilroy-Regular"
    static var GilroySemibold                    = "Gilroy-SemiBold"
    static var GilroyThin                        = "Gilroy-Thin"
    static var UIFontForLable                    = UIFont(name: MyFont.GilroyBold, size: 25)!
}
//MARK: COlor
struct MyColor {
    static let gradiantPink                        = Color(#colorLiteral(red: 0.9655817151, green: 0.1144879386, blue: 0.5043609142, alpha: 1))
    static let white                            = Color.white
    static let whiteBGTab                        = Color(#colorLiteral(red: 0.07843137255, green: 0.07843137255, blue: 0.08235294118, alpha: 1))
    static let darkBG                            = Color(#colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1))
    static let primaryLight                     = Color(#colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1294117647, alpha: 1))
    static let gradLight                        = Color(#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4274509804, alpha: 1))
    static let gradDark                            = Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0.2705882353, alpha: 1))
    static let lightGray                        = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1))
    static let textLight                        = Color(#colorLiteral(red: 0.3468961408, green: 0.3595512931, blue: 0.3872547098, alpha: 1))
    static let red                                = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    static let green                            = Color(#colorLiteral(red: 0.04425686598, green: 0.5219020844, blue: 0.0004890204873, alpha: 1))
    static let black                            = Color.black
    static let darkGray                         = Color(#colorLiteral(red: 0.1098039216, green: 0.1176470588, blue: 0.1333333333, alpha: 1))
    static let darkGrey                         = Color(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1))
    static let blue                             = Color.blue
    static let red50                            = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.5))
    static let sliderMaxColor                            = Color(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.5019607843, alpha: 0.36))
    static let sliderThumbColor                            = Color(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.5019607843, alpha: 1))
    static let textGray                             = Color(#colorLiteral(red: 0.4509803922, green: 0.4509803922, blue: 0.4509803922, alpha: 1))
    static let popupBackground                      = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1))
    static let hex4d4d4d                            = Color(hex: "#4D4D4D")
    
    static let gradientHorizontal                = LinearGradient(colors: [gradLight,gradDark], startPoint: .leading, endPoint: .trailing)
    static let gradient                            = LinearGradient(colors: [gradLight,gradDark], startPoint: .top, endPoint: .bottom)
    static let gradientBlack                    = LinearGradient(colors: [Color.clear,Color.black.opacity(0.2),Color.black], startPoint: .top, endPoint: .bottom)
    static let gradientCross                    = LinearGradient(colors: [gradLight,gradDark], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let grayGradient                        = LinearGradient(colors: [whiteBGTab], startPoint: .top, endPoint: .bottom)
    static let whiteGradient                    = LinearGradient(colors: [white], startPoint: .top, endPoint: .bottom)
    static let clearGradient                    = LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom)
//    static let gradiendleftToRight                = LinearGradient(colors: [MyColor.gradiantPink,MyColor.gradiantPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
}
struct MyImages {
    static let icTabChat                =   Image("ic-chat")
    static let icTabProfile             =   Image("ic-profile")
    static let icTabDiscover            =   Image("ic-discover")
    static let icLogo            =   Image("ic-logo")


}
//MARK: UserDefaults
struct Defaults {
    static let authToken                        = "authToken"
    static let userData                            = "user_data"
    static let deviceToken                        = "device_token"
    static let coins                            = "coins"
    static let language                            = "language"
    static let userID                            = "user_id"
    static let userName                            = "user_name"
    static let IsUserLogin                         = "is_user_login"
    static let FireBaseNotificationTopic          = "firebase_notification_topic"
    static let date                                = "date"
    static let dailyMatchLimit                    = "daily_match_limit"
    static let oneSignalUUID                    = "my_one_signal_id"
    static let isPopupStoped                    = "is_popup_stoped"
    static let favouriteSounds                    = "fav_sound"
    static func getBooleanValueForKey(key: String) -> Bool {
        if let value = UserDefaults.standard.value(forKey: key) as? Bool {
            return value
        }
        return false
    }
    static func setBooleanValue(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getStringValueForKey(key: String) -> String {
        if let value = UserDefaults.standard.value(forKey: key) as? String {
            return value
        }
        return ""
    }
    static func setStringValue(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getIntegerValueForKey(key: String) -> Int {
        if let value = UserDefaults.standard.value(forKey: key) as? Int {
            return value
        }
        return 0
    }
    static func setIntegerValue(value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func clear() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
//MARK:- Loader View
struct LoaderView: View {
    @Binding var isLoading : Bool
    var body: some View {
        if isLoading {
            GeometryReader { proxy in
                
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        MyColor.gradient
                            .frame(width: 30, height: 30, alignment: .center)
                            .mask(ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: MyColor.gradiantPink))
                                    .scaleEffect(1.5))
                            .padding(25)
                            .background(MyColor.white.opacity(1))
                            .cornerRadius(7)
                        Spacer()
                    }
                    Spacer()
                }
                .background(Color.black.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center).ignoresSafeArea().opacity(0.1))
//                .onTapGesture {
//                    print("Loading")
//                }
            }
        }
    }
}




//MARK: Param
struct Parameter {
    static let singer                           = "singer"
    static let ad_id                            = "ad_id"
    static let agora_token                      = "agora_token"
    static let agoraChannelName                 = "channle_name"
    static let one_signal_id                    = "one_signal_id"
    static let notificationType                 = "notification_type"
    static let call_type                        = "call_type"
    static let callStatus                       = "call_status"
    static let price                            = "price"
    static let summary                            = "summary"
    static let video                            = "video"
    static let thumbnail                        = "thumbnail"
    static let canComment                        = "can_comment"
    static let canSave                            = "can_save"
    static let hashtags                            = "hashtags"
    static let soundTitle                        = "sound_title"
    static let duration                            = "duration"
    static let image                            = "image"
    static let sound                            = "sound"
    static let blocked_users                    = "blocked_users"
    static let contact_info                        = "contact_info"
    static let description                        = "description"
    static let reason                            = "reason"
    static let oneSignalID                        = "one_signal_id"
    static let favourite_sounds                    = "favourite_sounds"
    static let comment_id                        = "comment_id"
    static let comment                            = "comment"
    static let key                                = "key"
    static let play                                = "play"
    static let pause                            = "pause"
    static let isLoading                        = "isLoading"
    static let fullname                            = "fullname"
    static let identity                            = "identity"
    static let deviceToken                        = "device_token"
    static let deviceType                        = "device_type"
    static let loginType                        = "login_type"
    static let myUserID                            = "my_user_id"
    static let userId                            = "user_id"
    static let toUserId                            = "to_user_id"
    static let start                            = "start"
    static let count                            = "count"
    static let postId                            = "post_id"
    static let soundId                            = "sound_id"
    static let hashtag                            = "hashtag"
    static let keyword                            = "keyword"
    static let username                            = "username"
    static let email                            = "email"
    static let bio                                = "bio"
    static let profileImage                        = "profile_image"
    static let profileCategoryId                = "profile_category_id"
    static let instaUrl                            = "insta_url"
    static let fbUrl                            = "fb_url"
    static let youtubeUrl                        = "youtube_url"
    static let isNotification                    = "is_notification"
    static let showLikedVideos                    = "show_liked_videos"
    static let showFollowingList                = "show_following_list"
    static let fromUserId                        = "from_user_id"
    static let coins                            = "coins"
    static let type                             = "type"
    static let amount                            = "amount"
    static let account                            = "account"
    static let gateway                            = "gateway"
    static let document_type                    = "document_type"
    static let document                            = "document"
    static let selfie                            = "selfie"
}
