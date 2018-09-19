//
//  StorePresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol StoreViewDelegate: AnyObject
{
    func update(dataSource: StoreViewDataSource?)
}

protocol StorePresenterDelegate: AnyObject
{
    func loadStore()
}

class StorePresenter
{
    weak var delegate : StoreViewDelegate?
    private var dataSource : StoreViewDataSource?
    private var model: Store?
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    required init()
    {
        
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    private func initDefaultStore()
    {
        let cars = [Car(manufacturer: "BMW", model: "34", topSpeed: 250, price: 20000, imageURL: nil),
                    Car(manufacturer: "Mercedes", model: "100", topSpeed: 222, price: 60000, imageURL: nil),
                    Car(manufacturer: "Toyota", model: "4", topSpeed: 200, price: 10000, imageURL: nil)]
        
        self.model = Store(withCars: cars, defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY)
    }
}

// MARK: - Transformation
extension StorePresenter
{
    class func transformToViewModel(store: Store) -> StoreViewModel?
    {
        var carDescriptions : [String] = []
        
        for car in store.cars
        {
            // All car descriptions must be successfully built, otherwise a nil view model will be returned
            if let description = car.description(forCurrency: store.defaultCurrency)
            {
                carDescriptions.append(description)
            }
            else
            {
                return nil
            }
        }
        
        return StoreViewModel(carDescriptions: carDescriptions)
    }
}

// MARK: - Delegate
extension StorePresenter : StorePresenterDelegate
{
    func loadStore()
    {
        initDefaultStore()
        
        fetchCurrencyData(handler: {(data, error) -> Void in
            if let currencies = data
            {
                if let model = self.model
                {
                    self.model = Store(withCars: model.cars, defaultCurrency: model.defaultCurrency, currencies: currencies)
                    
                    self.dataSource = StoreViewDataSource(model: StorePresenter.transformToViewModel(store: model))
                }
                
                self.delegate?.update(dataSource: self.dataSource)
            }
            else
            {
                if let err = error
                {
                    print("StorePresenter: network fetch failed! Error: \(err.rawValue)")
                }
            }
        })
    }
}

// MARK: - Networking
extension StorePresenter
{
    static let HTTP_TIMEOUT : Double = 5
    
    class func getAPIKey() -> String
    {
        return "2a40b989f394219b9235743c7d8cbd15"
    }
    
    class func getAPIURL() -> URL?
    {
        return URL(string: "http://apilayer.net/api/live?access_key=" + StorePresenter.getAPIKey())
    }
    
    func fetchCurrencyData(handler: @escaping([StoreCurrency]?, NetworkError?)->Void)
    {
        guard let url = StorePresenter.getAPIURL() else
        {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: StorePresenter.HTTP_TIMEOUT)
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let json = data
            {
                do
                {
                    let result = try StoreCurrency.initCurrencies(withJSON: json, defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY)
                    handler(result, nil)
                }
                catch
                {
                    handler(nil, NetworkError.BAD_RESPONSE)
                }
            }
            else
            {
                handler(nil, NetworkError.HTTP_ERROR)
            }
        }).resume()
    }
}
