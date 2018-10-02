//
//  ProductViewModel.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct ProductViewModel
{
    let manufacturer: String?
    let model: String?
    let description: String?
    let engine: String?
    let price: String?
    let imageURL: String?
    
    init(manufacturer: String?, model: String?, description: String?, engine: String?, price: String?, imageURL: String?)
    {
        self.manufacturer = manufacturer
        self.model = model
        self.description = description
        self.engine = engine
        self.price = price
        
        if imageURL == nil && manufacturer != nil
        {
            self.imageURL = CarPhotos.getCarImageURL(forManufacturer: manufacturer!)
        }
        else
        {
            self.imageURL = imageURL
        }
    }
}
