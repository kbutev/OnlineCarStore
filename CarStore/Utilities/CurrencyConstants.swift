//
//  CurrencyConstants.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct CurrencyConstants
{
    static let DEFAULT_CURRENCY = StoreCurrency(name: LanguageName.usd, symbol: "$", exchangeRate: 1.0)
    static let DESIRED_CURRENCIES = [LanguageName.usd, LanguageName.euro, LanguageName.bulgarianLev, LanguageName.czechCrown]
}
