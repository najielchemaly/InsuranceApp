//
//  Variables.swift
//  insurance
//
//  Created by MR.CHEMALY on 9/9/18.
//  Copyright © 2018 app-loads. All rights reserved.
//

import UIKit
import FSPagerView

let GMS_APIKEY = "AIzaSyB60KxWw8YByohE7WuO1ZEkAxfQcFEktvw"
let APPLE_LANGUAGE_KEY = "AppleLanguages"
let DEVICE_LANGUAGE_KEY = "AppleLocale"
let FACEBOOK_APP_ID = ""

var currentVC: UIViewController!
var isUserLoggedIn: Bool = false
var isReview: Bool = false
var currentUser: User = User()
var defaultBackground: String!
var notificationBadge: Int = 0

var appDelegate: AppDelegate {
    get {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        }
        
        return AppDelegate()
    }
}

//var termsUrlString = Services.getBaseUrl() + "/terms"
//var privacyUrlString = Services.getBaseUrl() + "/privacy"

enum AppStoryboard : String {
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

let mainStoryboard = AppStoryboard.Main.instance

struct Colors {
    static let topBarBlue: UIColor = UIColor(hexString: "#222299")!
    static let xlightBlue: UIColor = UIColor(hexString: "#4040b4")!
    static let lightBlue: UIColor = UIColor(hexString: "#2c2c9d")!
    static let darkBlue: UIColor = UIColor(hexString: "#10108c")!
    static let textDarkBlue: UIColor = UIColor(hexString: "#06062d")!
    static let textBlue: UIColor = UIColor(hexString: "#232399")!
    static let textLightGray: UIColor = UIColor(hexString: "#939393")!
    static let white: UIColor = UIColor(hexString: "#ffffff")!
}

struct Fonts {
    static let names: [String?] = UIFont.fontNames(forFamilyName: "Roboto")
    
    static var textFont_Regular: UIFont {
        get {
            if let fontName = Fonts.names[0] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
    static var textFont_Bold: UIFont {
        get {
            if let fontName = Fonts.names[1] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
    
    static var textFont_Light: UIFont {
        get {
            if let fontName = Fonts.names[2] {
                return UIFont.init(name: fontName, size: 16)!
            }
            
            return UIFont.init()
        }
    }
}

struct StoryboardIds {
    static let SigninNavigationController: String = "SigninNavigationController"
    static let SigninViewController: String = "SigninViewController"
    static let DashboardViewController: String = "DashboardViewController"
    static let ChangePasswordViewController: String = "ChangePasswordViewController"
    static let YourInsuranceViewController: String = "YourInsuranceViewController"
    static let RequestExpertViewController: String = "RequestExpertViewController"
    static let RequestExpertDetailsViewController: String = "RequestExpertDetailsViewController"
    static let CustomerSupportViewController: String = "CustomerSupportViewController"
    static let ForgotPasswordViewController: String = "ForgotPasswordViewController"
}

struct CellIds {
    static let DashboardTableViewCell: String = "DashboardTableViewCell"
    static let RequestExpertDetailsTableViewCell: String = "RequestExpertDetailsTableViewCell"
    static let MenuTableViewCell: String = "MenuTableViewCell"
}

struct Views {
    static let ToolbarView: String = "ToolbarView"
    static let MenuView: String = "MenuView"
}

struct Dimensions {
    static let cornerRadiusNormal: CGFloat = 10
    static let cornerRadiusMedium: CGFloat = 20
    static let cornerRadiusHigh: CGFloat = 30
}

enum MessageType: Int {
    case Notifications = 1
    case Messages = 2
}

enum Keys: String {
    case AccessToken = "TOKEN"
    case AppLanguage = "APP-LANGUAGE"
    case AppVersion = "APP-VERSION"
    case DeviceId = "ID"
}

enum SegueId: String {
    case None
    
    var identifier: String {
        return String(describing: self).lowercased()
    }
}

enum Language: Int {
    
    case Arabic = 1
    case English = 2
    
}

public enum AddActivityComingFrom {
    case none
    case daily
    case additional
}

public enum WebViewComingFrom {
    case none
    case terms
    case privacy
}

func getYears() -> NSMutableArray {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let strDate = formatter.string(from: Date.init())
    if let intDate = Int(strDate) {
        let yearsArray: NSMutableArray = NSMutableArray()
        for i in (1964...intDate).reversed() {
            yearsArray.add(String(format: "%d", i))
        }
        
        return yearsArray
    }
    
    return NSMutableArray()
}

func getYearsFrom(yearString: String) -> String {
    let currentYearString = Calendar.current.component(Calendar.Component.year, from: Date())
    if let year = Int(yearString) {
        let currentYear = Int(currentYearString)
        return String(currentYear-year)
    }
    
    return yearString
}

public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return "\(year) years ago"
    }
    
    if let year = components.year, year >= 1 {
        return "Last year"
    }
    
    if let month = components.month, month >= 2 {
        return "\(month) months ago"
    }
    
    if let month = components.month, month >= 1 {
        return "Last month"
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return "\(week) weeks ago"
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return "Last week"
    }
    
    if let day = components.day, day >= 2 {
        return "\(day) days ago"
    }
    
    if let day = components.day, day >= 1 {
        return "Yesterday"
    }
    
    if let hour = components.hour, hour >= 2 {
        return "\(hour) hours ago"
    }
    
    if let hour = components.hour, hour >= 1 {
        return "An hour ago"
    }
    
    if let minute = components.minute, minute >= 2 {
        return "\(minute) minutes ago"
    }
    
    if let minute = components.minute, minute >= 1 {
        return "A minute ago"
    }
    
    if let second = components.second, second >= 3 {
        return "Just now"
    }
    
    return "Just now"
    
}

func updateNotificationBadge() {
    let userDefaults = UserDefaults.standard
    if let notificationNumber = userDefaults.value(forKey: "notificationNumber") as? String {
        if let notificationBadge = Int(notificationNumber) {
            userDefaults.set(String(describing: notificationBadge + 1), forKey: "notificationNumber")
        }
    } else {
        userDefaults.set(String(describing: "1"), forKey: "notificationNumber")
    }
    userDefaults.synchronize()
}

class PagerView: FSPagerView {
    
}

