//
//  SettingsView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

// This protocol is used for actions. Whenever the picker is modified, the delegate will be alerted
protocol SettingsCurrencyViewDelegate : class
{
    func didSelectCurrency(currencyName: CurrencyName)
}

class SettingsCurrencyDataSource : NSObject, UIPickerViewDataSource
{
    private let currencyNames : [CurrencyName]?
    
    init(currencyNames : [CurrencyName]?)
    {
        self.currencyNames = currencyNames
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if let currencyNames = self.currencyNames
        {
            return currencyNames.count
        }
        
        return 0
    }
}

class SettingsCurrencyDelegate : NSObject, UIPickerViewDelegate
{
    private let currencyNames : [CurrencyName]?
    private let actionDelegate: SettingsCurrencyViewDelegate?
    
    init(currencyNames : [CurrencyName]?, actionDelegate: SettingsCurrencyViewDelegate?)
    {
        self.currencyNames = currencyNames
        self.actionDelegate = actionDelegate
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if let currencyNames = self.currencyNames
        {
            return currencyNames[row].rawValue
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let currencyNames = self.currencyNames else {
            return
        }
        
        if (0..<currencyNames.count).contains(row)
        {
            actionDelegate?.didSelectCurrency(currencyName: currencyNames[row])
        }
    }
}

class SettingsView : UIView
{
    @IBOutlet private weak var labelCurrency: UILabel!
    @IBOutlet private weak var pickerCurrency: UIPickerView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    func setup()
    {
        let layoutGuide = self.safeAreaLayoutGuide
        
        labelCurrency.translatesAutoresizingMaskIntoConstraints = false
        labelCurrency.widthAnchor.constraint(equalToConstant: 256.0).isActive = true
        labelCurrency.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10.0).isActive = true
        labelCurrency.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0.0).isActive = true
        labelCurrency.textAlignment = .center
        
        pickerCurrency.translatesAutoresizingMaskIntoConstraints = false
        pickerCurrency.topAnchor.constraint(equalTo: labelCurrency.bottomAnchor, constant: 10.0).isActive = true
        pickerCurrency.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0.0).isActive = true
    }
}

// MARK: - Methods used by the view controller to manipulate the interface
extension SettingsView
{
    func selectCurrencyPickerValue(row: Int)
    {
        DispatchQueue.main.async {
            self.pickerCurrency.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    func updateCurrencyPicker(dataSource: SettingsCurrencyDataSource?, delegate: SettingsCurrencyDelegate?)
    {
        DispatchQueue.main.async {
            self.pickerCurrency.dataSource = dataSource
            self.pickerCurrency.delegate = delegate
            self.pickerCurrency.reloadAllComponents()
        }
    }
}

// MARK: - Factories
extension SettingsView
{
    class func create(owner: Any) -> SettingsView?
    {
        let bundle = Bundle.main
        let nibName = String(describing: SettingsView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: owner, options: nil).first as? SettingsView
    }
}
