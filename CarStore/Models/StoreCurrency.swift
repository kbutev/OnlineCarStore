//
//  StoreCurrency.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

enum CurrencyName : String
{
    case USD = "USD"
    case EUR = "EUR"
    case CZK = "CZK"
    case BGN = "BGN"
}

enum CurrencySymbols : String
{
    case USD = "$"
    case EUR = "€"
    case CZK = "Kč"
    case BGN = "Лв."
    
    static func symbol(for language: CurrencyName) -> CurrencySymbols
    {
        switch language
        {
        case .USD: return .USD
        case .EUR: return .EUR
        case .BGN: return .BGN
        case .CZK: return .CZK
        }
    }
}

enum StoreCurrencyError: Error {
    case jsonUnwrapError
}

struct StoreCurrency
{
    let name: CurrencyName
    let symbol: CurrencySymbols
    let exchangeRate: Double
    
    init(name: CurrencyName, symbol: CurrencySymbols, exchangeRate: Double)
    {
        self.name = name
        self.symbol = symbol
        self.exchangeRate = exchangeRate
    }
    
    init(withJSON json: [String : Any], defaultCurrency: StoreCurrency, currencyName: CurrencyName) throws
    {
        self.name = currencyName
        
        self.symbol = CurrencySymbols.symbol(for: currencyName)
        
        let exchangeRateKey = String("\(defaultCurrency.name)\(currencyName)")
        
        guard let exchangeRate = json[exchangeRateKey] as? Double else {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        self.exchangeRate = exchangeRate
    }
    
    static func initCurrencies(withJSON json: Data, defaultCurrency: StoreCurrency) throws -> [StoreCurrency]
    {
        guard let data = try JSONSerialization.jsonObject(with: json, options: []) as? [String : Any] else
        {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        var currencies : [StoreCurrency] = []
        
        let quotes = data["quotes"]
        
        guard let list = quotes as? [String : Any] else
        {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        for desiredCurrency in CurrencyConstants.DESIRED_CURRENCIES
        {
            // Skip the construction of the default currency, we will add it manually to the array
            if desiredCurrency == defaultCurrency.name
            {
                continue
            }
            
            let currency = try StoreCurrency(withJSON: list, defaultCurrency: defaultCurrency, currencyName: desiredCurrency)
            
            currencies.append(currency)
        }
        
        currencies.append(defaultCurrency)
        
        return currencies
    }
}
