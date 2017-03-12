//
//  FRZColors.swift
//  FRZColors
//
//  Created by Alex Neminsky on 04.03.17.
//  Copyright © 2017 SkaKot. All rights reserved.
//

import UIKit


class Colors {
    
    private struct Constants {
        static let defKey = "Current Color Theme"
    }
    
    private let themes: [ColorTheme] = {
        [
        ColorTheme(name: "green", baseColor: .green, lightColor: .yellow, darkColor: .green, contrastColor: .white, altColor: .blue, fontName: "arial"),
        ColorTheme(name: "red", baseColor: .red, lightColor: .purple, darkColor: .red, contrastColor: .black, altColor: .gray, fontName: "Avenir Next")
        ]
    }()
    
    
    private lazy var currentTheme: ColorTheme = {
        if let currentThemeName = UserDefaults.standard.object(forKey: Constants.defKey) as? String, let theme = self.themeWithName(currentThemeName){
            return theme
        } else {
            return self.themes.first!
        }
    }()
    
    // MARK: -
    static let sharedInstance: Colors = Colors()
    
    // MARK: - Public vars
    
    var base: UIColor { return currentTheme.baseColor }
    var light: UIColor { return currentTheme.lightColor }
    var dark: UIColor { return currentTheme.darkColor }
    var contrast: UIColor { return currentTheme.contrastColor }
    var alt: UIColor { return currentTheme.altColor }
    
    var green: UIColor { return currentTheme.green ?? .green }
    var red: UIColor  { return currentTheme.red  ?? .red}
    var blue: UIColor  { return currentTheme.blue ?? .blue }
    var yellow: UIColor  { return currentTheme.yellow ?? .yellow }
    var lightGray: UIColor  { return currentTheme.lightGray ?? .lightGray }
    var darkGray: UIColor  { return currentTheme.darkGray ?? .darkGray }
    
    var fontName: String { return currentTheme.fontName }
    
    let notifName = Notification.Name("ColorsThemeDidChange")
    
    var currentThemeName: String { return currentTheme.name }
    
    var themesNames: [String] {
        let array = themes.map { (theme) -> String in
            return theme.name
        }
        return array
    }
    
    // MARK: - Public methods
    
    func setThemeWithName(_ name: String) throws {
        
        guard let theme = themeWithName(name) else {
            throw ColorsError.themeNotFound
        }
        
        guard currentTheme.name != theme.name else {
            throw ColorsError.themeIsAlreadyNow
        }
        
        currentTheme = theme
        UserDefaults.standard.set(theme.name, forKey: Constants.defKey)
        themeChangedNotification()
        
    }
    
    // MARK: - Private methods

    private func themeWithName(_ name: String) -> ColorTheme? {
        
        var theme: ColorTheme?
        
        themes.forEach({ (nextTheme) in
            if nextTheme.name == name {
                theme = nextTheme
            }
        })
        
        return theme
    }
    
    private func themeChangedNotification () {
        let notif = Notification.init(name: notifName)
        NotificationCenter.default.post(notif)
    }
    
}

fileprivate struct ColorTheme {
    
    let name: String
    //themes colors
    let baseColor: UIColor
    let lightColor: UIColor
    let darkColor: UIColor
    let contrastColor: UIColor
    let altColor: UIColor
    
    //standart colors
    let green: UIColor? = nil
    let red: UIColor?  = nil
    let blue: UIColor?  = nil
    let yellow: UIColor?  = nil
    let lightGray: UIColor?  = nil
    let darkGray: UIColor?  = nil
    
    //font
    let fontName: String
    
}

enum ColorsError: Error {
    case themeNotFound
    case themeIsAlreadyNow
}

extension UIColor {
    static var myBase: UIColor { return Colors().base }
    static var myLight: UIColor { return Colors().light }
    static var myDark: UIColor { return Colors().dark }
    static var myContrast: UIColor { return Colors().contrast }
    static var myAlt: UIColor { return Colors().alt }
    static var myGreen: UIColor { return Colors().green }
    static var myRed: UIColor { return Colors().red }
    static var myBlue: UIColor { return Colors().blue }
    static var myYellow: UIColor { return Colors().yellow }
    static var myLightGray: UIColor { return Colors().lightGray }
    static var myDarkGray: UIColor { return Colors().darkGray }
}


