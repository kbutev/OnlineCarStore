//
//  Basket.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct Basket
{
    var cars: [Car]
    let defaultCurrency: StoreCurrency
    
    init(defaultCurrency: StoreCurrency)
    {
        self.cars = []
        self.defaultCurrency = defaultCurrency
    }
    
    init(withCars cars: [Car], defaultCurrency: StoreCurrency)
    {
        self.cars = cars
        self.defaultCurrency = defaultCurrency
    }
    
    mutating func add(_ car: Car)
    {
        cars.append(car)
    }
    
    func getTotalPrice() -> Int
    {
        var price = 0
        
        for e in 0..<cars.count
        {
            price += cars[e].price
        }
        
        return price
    }
    
    func getTotalPriceWithSymbol(forCurrency currency: StoreCurrency) -> String?
    {
        let price = getTotalPrice()
        
        let formatter = NumberFormatter()
        
        formatter.allowsFloats = false
        
        if var result = formatter.string(from: NSNumber(value: Double(price) * currency.exchangeRate))
        {
            result.append(currency.symbol.rawValue)
            
            return result
        }
        
        return nil
    }
}
