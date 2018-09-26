//
//  CurrencyConstants.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct CurrencyConstants
{
    static let DEFAULT_CURRENCY = StoreCurrency(name: .USD, exchangeRate: 1.0)
    static let DESIRED_CURRENCIES : [CurrencyName] = [.USD, .EUR, .BGN, .CZK]
}

struct CurrencySymbol
{
    let currencyName : CurrencyName
    
    init(_ currencyName: CurrencyName)
    {
        self.currencyName = currencyName
    }
    
    var value : (prefix: String, suffix: String) {
        get {
            switch currencyName {
            case .USD:
                return ("$", "")
            case .BGN:
                return ("", "Лв.")
            case .EUR:
                return ("€", "")
            case .CZK:
                return ("", "Kč")
            }
        }
    }
}

struct CurrencyConverter
{
    let currencyValue: Double
    let exchangeRate: Double
    
    init(value: Int, exchangeRate: Double)
    {
        self.currencyValue = Double(value)
        self.exchangeRate = exchangeRate
    }
    
    init(value: Double, exchangeRate: Double)
    {
        self.currencyValue = value
        self.exchangeRate = exchangeRate
    }
    
    var value : String? {
        get {
            let formatter = NumberFormatter()
            
            formatter.allowsFloats = false
            
            if let result = formatter.string(from: NSNumber(value: currencyValue * exchangeRate))
            {
                return result
            }
            
            return nil
        }
    }
}
