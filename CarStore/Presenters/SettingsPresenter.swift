//
//  SettingsPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: AnyObject
{
    func updateCurrencyPicker(dataSource: SettingsCurrencyDataSource?, delegate: SettingsCurrencyDelegate?)
    func selectCurrencyPickerValue(row: Int)
}

protocol SettingsPresenterDelegate: AnyObject
{
    func update()
    
    func didSelectCurrency(currencyName: CurrencyName)
    
    func saveAndGoBack()
}

class SettingsPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: SettingsViewDelegate?
    private var currencyDataSource : SettingsCurrencyDataSource?
    private var currencyDelegate : SettingsCurrencyDelegate?
    
    private var defaultCurrency: StoreCurrency
    private var currencies: [StoreCurrency]
    private let viewModel: SettingsViewModel?
    
    required init(withRouter router: Router = Router.singleton, defaultCurrency: StoreCurrency, currencies: [StoreCurrency])
    {
        self.router = router
        self.defaultCurrency = defaultCurrency
        self.currencies = currencies
        self.viewModel = nil
    }
}

// MARK: - Delegate
extension SettingsPresenter : SettingsPresenterDelegate
{
    func update()
    {
        var currencyNames : [CurrencyName] = []
        
        for e in 0..<self.currencies.count
        {
            currencyNames.append(self.currencies[e].name)
        }
        
        let firstTimeBeingSet = self.currencyDataSource == nil
        
        self.currencyDataSource = SettingsCurrencyDataSource(currencyNames: currencyNames)
        self.currencyDelegate = SettingsCurrencyDelegate(currencyNames: currencyNames, actionDelegate: delegate as? SettingsCurrencyViewDelegate)
        
        delegate?.updateCurrencyPicker(dataSource: self.currencyDataSource, delegate: self.currencyDelegate)
        
        // Select the correct picker value - that current application default currency
        if firstTimeBeingSet
        {
            for e in 0..<self.currencies.count
            {
                if self.currencies[e].name == defaultCurrency.name
                {
                    delegate?.selectCurrencyPickerValue(row: e)
                    break
                }
            }
        }
    }
    
    func didSelectCurrency(currencyName: CurrencyName)
    {
        if defaultCurrency.name == currencyName
        {
            return
        }
        
        for e in 0..<currencies.count
        {
            if currencies[e].name == currencyName
            {
                defaultCurrency = currencies[e]
                return
            }
        }
    }
    
    func saveAndGoBack()
    {
        router.goBackFromSettings(selectedCurrency: defaultCurrency)
    }
}
