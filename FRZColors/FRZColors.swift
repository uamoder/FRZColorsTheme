//
//  FRZColors.swift
//  FRZColors
//
//  Created by Alex Neminsky on 04.03.17.
//  Copyright © 2017 SkaKot. All rights reserved.
//

import UIKit

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

class Colors {
    
    enum ColorsError: Error {
        case themeNotFound
        case themeIsAlreadyNow
    }
    
    private let themes: [ColorTheme] = {
        [
        ColorTheme(name: "green", baseColor: .green, lightColor: .yellow, darkColor: .green, contrastColor: .white, altColor: .blue, fontName: "arial"),
        ColorTheme(name: "red", baseColor: .red, lightColor: .purple, darkColor: .red, contrastColor: .black, altColor: .gray, fontName: "Avenir Next")
        ]
    }()
    
    private let defKey = "Current Color Theme"
    private lazy var currentTheme: ColorTheme = {
        if let currentThemeName = UserDefaults.standard.string(forKey: self.defKey), let theme = self.themeWithName(currentThemeName){
            return theme
        } else {
            return self.themes.first!
        }
    }()
    
    // MARK: -
    static let sharedInstance: Colors = Colors()
    
    init() {

    }
    
    // MARK: - Public vars
    
    var currentThemeName: String { return currentTheme.name }
    
    var base: UIColor { return currentTheme.baseColor }
    var light: UIColor { return currentTheme.lightColor }
    var dark: UIColor { return currentTheme.darkColor }
    var contrast: UIColor { return currentTheme.contrastColor }
    var alt: UIColor { return currentTheme.altColor }
    
    var green: UIColor? { return currentTheme.green }
    var red: UIColor?  { return currentTheme.red }
    var blue: UIColor?  { return currentTheme.blue }
    var yellow: UIColor?  { return currentTheme.yellow }
    var lightGray: UIColor?  { return currentTheme.lightGray }
    var darkGray: UIColor?  { return currentTheme.darkGray }
    
    var fontName: String { return currentTheme.fontName }
    
    // MARK: - Public methods
    
    func setThemeWithName(_ name: String) throws {
        
        guard let theme = themeWithName(name) else {
            throw ColorsError.themeNotFound
        }
        
        guard currentTheme.name != theme.name else {
            throw ColorsError.themeIsAlreadyNow
        }
        
        currentTheme = theme
        
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
        
    }
    
}

