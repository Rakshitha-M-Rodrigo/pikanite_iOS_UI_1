

import Foundation

private var isSandbox = true

struct RequestUrls {
    
    private static var liveUrl = "https://pikanite.com:8081" //"https://container.pikanite.com"
    private static var sandboxUrl = "https://pikanite.com:8082"
    
    /**
     Returns the base url based on isSandbox property.
     */
    public static func getBaseUrl() -> String {
        if isSandbox {
            return sandboxUrl
        } else {
            return liveUrl
        }
    }
    
    static var loginUrl: String {
        get {
            return getBaseUrl() + "/user/login"
        }
    }
    
    static var registrationUrl: String {
        get {
            return getBaseUrl() + "/user"
        }
    }
    
    static var memberUpdateUrl: String {
        get {
            return getBaseUrl() + "/user/update"
        }
    }
    
    static var passwordChangeUrl: String {
        get {
            return getBaseUrl() + "/user/changepwd"
        }
    }
    
    static var profilePicChangeUrl: String {
        get {
            return getBaseUrl() + "/user/upload"
        }
    }
    
    static var forgotPasswordUrl: String {
        get {
            return getBaseUrl() + "/public/users/\(String(describing: UserDefaults.standard.string(forKey: "userID")))/profilePic.jpg"
        }
    }
    
    static var getProfileUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var locationUpdatenUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getEventsUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var eventCalendarUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var eventImageUploadUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getEventAlbumsOpmUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getEventAlbumsEmbassyUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getEventAlbumUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var rewardPointSummaryUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var completeActivityUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var redeemRewardUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var redeemRewardListUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var rewardsUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getMemberListUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }

    static var postMemberListUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    

    static var notificationsUrl: String {
        get {
            return getBaseUrl() + ""

        }
    }
    
    static var notificationsseenUrl: String {
        get {
            return getBaseUrl() + ""
            
        }
    }
    
    static var reportImageUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getPurchaseHistoryUrl: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var eventTicketInventory: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var validatePromoCodes: String {
        get {
            return getBaseUrl() + ""
        }
    }
    

    static var upcomingEvents: String {
        get {
            return getBaseUrl() + ""
            
        }
    }

    static var getUpcomingEvents: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getBtToken: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var buyTickets: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var getUserGallery: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var deleteUserImages: String {
        get {
            return getBaseUrl() + ""
        }
    }
    static var AddPaymentMethod: String {
        get {
            return getBaseUrl() + ""
        }
    }
    
    static var bookHotel: String {
        get {
            return getBaseUrl() + "/booking"
        }
    }
    
    static var getBookings: String {
        get {
            return getBaseUrl() + "/booking/info"
        }
    }
    
    static var getAllBookings: String {
        get {
            return getBaseUrl() + "/booking"
        }
    }
    
    static var offers: String {
        get {
            return getBaseUrl() + "/offer"
        }
    }
    
    static var hotelProfile: String {
        get {
            return getBaseUrl() + "/hotel"
        }
    }
    
    static var checkUser: String {
        get {
            return getBaseUrl() + "/user/checkuser"
        }
    }
    
    static var socialMediaRegister: String {
        get {
            return getBaseUrl() + "/user/social"
        }
    }
    
    static var userProfileUpdateUrl: String {
        get {
            return getBaseUrl() + "/user/update"
        }
    }
    
    static var updatePassword: String {
        get {
            return getBaseUrl() + "/user/changepwd"
        }
    }
    
    static var getServerCurrentTime: String {
        get {
            return getBaseUrl() + "/info/dateAndTimeNow"
        }
    }
    
    static var checkPromoCode: String {
        get {
            return getBaseUrl() + "/promo/"
        }
    }
    
    static var hotelProfileInfo: String {
        get {
            return getBaseUrl() + "/offer/info"
        }
    }
}
