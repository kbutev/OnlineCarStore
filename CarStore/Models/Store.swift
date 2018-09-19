//
//  Store.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct Store
{
    let cars: [Car]
    let defaultCurrency: StoreCurrency
    let currencies: [StoreCurrency]
    
    init(withCars cars: [Car], defaultCurrency: StoreCurrency)
    {
        self.cars = cars
        self.defaultCurrency = defaultCurrency
        self.currencies = [defaultCurrency]
    }
    
    init(withCars cars: [Car], defaultCurrency: StoreCurrency, currencies: [StoreCurrency])
    {
        self.cars = cars
        self.defaultCurrency = defaultCurrency
        self.currencies = currencies
    }
    
    func getCurrency(byName name: LanguageName) -> StoreCurrency?
    {
        for e in 0..<currencies.count
        {
            if currencies[e].name == name
            {
                return currencies[e]
            }
        }
        
        return nil
    }
}
