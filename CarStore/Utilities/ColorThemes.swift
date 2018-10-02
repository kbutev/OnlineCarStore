//
//  ColorThemes.swift
//  CarStore
//
//  Created by Kristiyan Butev on 1.10.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

enum ColorTheme : String
{
    case blue = "Blue"
    case red = "Red"
    case green = "Green"
    
    func getUIColor() -> UIColor
    {
        switch self {
        case .blue:
            return UIColor(red: 0, green: 111.0/255.0, blue: 1.0, alpha: 1.0)
        case .red:
            return UIColor.red
        case .green:
            return UIColor(red: 2.0/255.0, green: 158.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        }
    }
}

struct ColorThemesConstants
{
    static let DEFAULT_CURRENCY = ColorTheme.blue
    static let THEMES : [ColorTheme] = [.blue, .red, .green]
}
