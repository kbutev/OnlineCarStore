//
//  Car.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct Car
{
    let manufacturer: String
    let model: String
    let description: String
    let topSpeed: Int
    let price: Int
    let imageURL: String?
    
    init(manufacturer: String, model: String, description: String, topSpeed: Int, price: Int, imageURL: String?)
    {
        self.manufacturer = manufacturer
        self.model = model
        self.description = description
        self.topSpeed = topSpeed
        self.price = price
        self.imageURL = imageURL
    }
    
    func getPriceWithSymbol(forCurrency currency: StoreCurrency) -> String?
    {
        if let number = CurrencyConverter(value: price, exchangeRate: currency.exchangeRate).value
        {
            var result = currency.symbol.value.prefix
            result.append(number)
            result.append(currency.symbol.value.suffix)
            
            return result
        }
        
        return nil
    }
}

extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.manufacturer == rhs.manufacturer && lhs.model == rhs.model
    }
}
