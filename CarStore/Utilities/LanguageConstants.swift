//
//  LanguageConstants.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

enum LanguageName : String
{
    case usd = "USD"
    case euro = "EUR"
    case czechCrown = "CZK"
    case bulgarianLev = "BGN"
}

enum LanguageCurrencySymbols : String
{
    case usd = "$"
    case euro = "€"
    case czechCrown = "Kč"
    case bulgarianLev = "Лв."
    
    static func getSymbolFor(language: LanguageName) -> String
    {
        switch language
        {
        case .usd:
            return "$"
        case .euro:
            return "€"
        case .bulgarianLev:
            return "Лв."
        case .czechCrown:
            return "Kč"
        }
    }
}
