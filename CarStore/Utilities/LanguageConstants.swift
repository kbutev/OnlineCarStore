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
    case USD = "USD"
    case EUR = "EUR"
    case CZK = "CZK"
    case BGN = "BGN"
}

struct CurrencySymbols
{
    static func symbol(for language: LanguageName) -> String
    {
        switch language
        {
        case .USD: return "$"
        case .EUR: return "€"
        case .BGN: return "Лв."
        case .CZK: return "Kč"
        }
    }
}
