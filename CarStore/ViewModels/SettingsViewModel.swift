//
//  SettingsViewModel.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

enum SettingsViewModelSorting
{
    case name, priceHighest, priceLowest, speedHighest, speedLowest
}

struct SettingsViewModel
{
    let selectedCurrency : String
    let selectedSort : SettingsViewModelSorting
}
