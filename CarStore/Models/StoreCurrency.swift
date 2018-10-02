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

enum StoreCurrencyError: Error {
    case jsonUnwrapError
}

struct StoreCurrency
{
    let name: CurrencyName
    let exchangeRate: Double
    
    init(name: CurrencyName, exchangeRate: Double)
    {
        self.name = name
        self.exchangeRate = exchangeRate
    }
    
    init(withJSON json: [String : Any], defaultCurrency: StoreCurrency, currencyName: CurrencyName) throws
    {
        self.name = currencyName
        
        let exchangeRateKey = String("\(defaultCurrency.name)\(currencyName)")
        
        guard let exchangeRate = json[exchangeRateKey] as? Double else {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        self.exchangeRate = exchangeRate
    }
    
    static func initCurrencies(withJSON json: Data, defaultCurrency: StoreCurrency, desiredCurrencies: [CurrencyName] = CurrencyConstants.DESIRED_CURRENCIES) throws -> [StoreCurrency]
    {
        guard let jsonUnwrapped = try? JSONSerialization.jsonObject(with: json, options: []) else
        {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        guard let data = jsonUnwrapped as? [String : Any] else
        {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        var currencies : [StoreCurrency] = []
        
        let quotes = data["quotes"]
        
        guard let list = quotes as? [String : Any] else
        {
            throw StoreCurrencyError.jsonUnwrapError
        }
        
        for desiredCurrency in desiredCurrencies
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
    
    var symbol : CurrencySymbol {
        get {
            return CurrencySymbol(name)
        }
    }
}
