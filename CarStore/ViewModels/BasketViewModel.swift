//
//  BasketViewModel.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct BasketViewModel
{
    let carDescriptions : [String]
    let totalPrice: String?
    
    init(carDescriptions: [String], totalPrice: String?)
    {
        self.carDescriptions = carDescriptions
        self.totalPrice = totalPrice
    }
}
