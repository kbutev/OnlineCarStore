//
//  Car.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

enum CarError: Error {
    case jsonUnwrapError
}

struct Car
{
    let manufacturer: String
    let model: String
    let description: String
    let engine: String
    let price: Int
    let imageURL: String?
    
    init(manufacturer: String, model: String, description: String, engine: String, price: Int, imageURL: String?)
    {
        self.manufacturer = manufacturer
        self.model = model
        self.description = description
        self.engine = engine
        self.price = price
        self.imageURL = imageURL
    }
    
    init(withJSON json: [String : Any]) throws
    {
        self.manufacturer = ""
        self.model = ""
        self.description = ""
        self.engine = ""
        self.price = 0
        self.imageURL = nil
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
    
    static func initCars(withJSON json: Data) throws -> [Car]
    {
        guard let jsonUnwrapped = try? JSONSerialization.jsonObject(with: json, options: []) else
        {
            throw CarError.jsonUnwrapError
        }
        
        guard let trims = jsonUnwrapped as? [String : Any] else
        {
            throw CarError.jsonUnwrapError
        }
        
        guard let list = trims["Trims"] as? [[String : Any]] else
        {
            throw CarError.jsonUnwrapError
        }
        
        var cars : [Car] = []
        
        for car in list
        {
            let manufacturer = car["model_make_id"] as? String ?? "unknown"
            let model = car["model_trim"] as? String ?? "unknown"
            let makeCountry = car["make_country"] as? String ?? "unknown"
            let modelEngine = car["model_engine_cc"] as? String ?? ""
            let engineCylinders = car["model_engine_cyl"] as? String ?? ""
            let engine = modelEngine + "," + engineCylinders + " cyl"
            let priceS = car["model_weight_kg"] as? String ?? "0"
            guard var price = Int(priceS) else {
                throw CarError.jsonUnwrapError
            }
            
            let description = String("Model name: \(model), country maker: \(makeCountry)")
            
            cars.append(Car(manufacturer: manufacturer, model: model, description: description, engine: engine, price: price, imageURL: nil))
        }
        
        return cars
    }
}

extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.manufacturer == rhs.manufacturer && lhs.model == rhs.model
    }
}
