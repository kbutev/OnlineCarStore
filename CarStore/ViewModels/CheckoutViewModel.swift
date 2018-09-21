//
//  CheckoutViewModel.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct CheckoutViewModel
{
    let carDescriptions : [String]
    let basketDescription: String?
    
    init(carDescriptions: [String], basketDescription: String?)
    {
        self.carDescriptions = carDescriptions
        self.basketDescription = basketDescription
    }
}
