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
    func updateThemesPicker(dataSource: SettingsThemesDataSource?, delegate: SettingsThemesDelegate?)
    func selectCurrencyPickerValue(row: Int)
    func selectThemePickerValue(row: Int)
}

protocol SettingsPresenterDelegate: AnyObject
{
    func update()
    
    func didSelectCurrency(currencyName: CurrencyName)
    func didSelectTheme(theme: ColorTheme)
    
    func saveAndGoBack()
}

class SettingsPresenter
{
    static let APPLICATION_THEME_KEY_USER_DEFAULTS = "APPLICATION_THEME_KEY_USER_DEFAULTS"
    
    private var router : RouterProtocol
    
    weak var delegate: SettingsViewDelegate?
    private var currencyDataSource : SettingsCurrencyDataSource?
    private var currencyDelegate : SettingsCurrencyDelegate?
    private var themesDataSource : SettingsThemesDataSource?
    private var themesDelegate : SettingsThemesDelegate?
    
    private var defaultCurrency: StoreCurrency
    private var currencies: [StoreCurrency]
    private var applicationTheme: ColorTheme
    private let viewModel: SettingsViewModel?
    
    required init(withRouter router: Router = Router.singleton, defaultCurrency: StoreCurrency, currencies: [StoreCurrency], applicationTheme: ColorTheme)
    {
        self.router = router
        self.defaultCurrency = defaultCurrency
        self.currencies = currencies
        self.applicationTheme = applicationTheme
        self.viewModel = nil
    }
}

// MARK: - Delegate
extension SettingsPresenter : SettingsPresenterDelegate
{
    func update()
    {
        // Currency picker and themes picker
        var currencyNames : [CurrencyName] = []
        
        for e in 0..<self.currencies.count
        {
            currencyNames.append(self.currencies[e].name)
        }
        
        let themes = ColorThemesConstants.THEMES
        
        let firstTimeBeingSet = self.currencyDataSource == nil
        
        currencyDataSource = SettingsCurrencyDataSource(currencyNames: currencyNames)
        currencyDelegate = SettingsCurrencyDelegate(currencyNames: currencyNames, actionDelegate: delegate as? SettingsCurrencyViewDelegate)
        
        themesDataSource = SettingsThemesDataSource(themes: themes)
        themesDelegate = SettingsThemesDelegate(themes: themes, actionDelegate: delegate as? SettingsThemesViewDelegate)
        
        delegate?.updateCurrencyPicker(dataSource: currencyDataSource, delegate: currencyDelegate)
        delegate?.updateThemesPicker(dataSource: themesDataSource, delegate: themesDelegate)
        
        // Select the proper picker value
        // For currency picker its the current application default currency
        // For themes picker its the current application theme
        if firstTimeBeingSet
        {
            for e in 0..<currencies.count
            {
                if currencies[e].name == defaultCurrency.name
                {
                    delegate?.selectCurrencyPickerValue(row: e)
                    break
                }
            }
            
            for e in 0..<themes.count
            {
                if themes[e] == applicationTheme
                {
                    delegate?.selectThemePickerValue(row: e)
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
    
    func didSelectTheme(theme: ColorTheme)
    {
        self.applicationTheme = theme
    }
    
    func saveAndGoBack()
    {
        router.goBackFromSettings(selectedCurrency: defaultCurrency, applicationTheme: applicationTheme)
    }
}
