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
