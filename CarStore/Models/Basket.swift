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
    var defaultCurrency: StoreCurrency
    
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
    
    mutating func remove(_ car: Car)
    {
        for e in 0..<cars.count
        {
            if cars[e] == car
            {
                cars.remove(at: e)
                return
            }
        }
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
        if let number = CurrencyConverter(value: getTotalPrice(), exchangeRate: currency.exchangeRate).value
        {
            var result = currency.symbol.value.prefix
            result.append(number)
            result.append(currency.symbol.value.suffix)
            
            return result
        }
        
        return nil
    }
}
