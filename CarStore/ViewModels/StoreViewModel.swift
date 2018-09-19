//
//  StoreViewModel.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct StoreViewModel
{
    let carDescriptions : [String]
    
    init(carDescriptions: [String])
    {
        self.carDescriptions = carDescriptions
    }
}
