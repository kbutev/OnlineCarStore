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
    func updateTheme(theme: ColorTheme?)
    func updateStore(dataSource: StoreViewDataSource?)
    func updateBasket(viewModel: BasketViewModel?)
}

protocol StorePresenterDelegate: AnyObject
{
    func loadStore()
    
    func clearBasketCars()
    func setBasketCars(cars: [Car])
    func addCarToBasket(car: Car)
    func removeCarFromBasket(car: Car)
    
    func setDefaultCurrency(defaultCurrency: StoreCurrency)
    func setApplicationTheme(applicationTheme: ColorTheme)
    
    func goToProductScene(atTableIndex index: IndexPath)
    func goToBasket()
    func goToSettings()
}

class StorePresenter
{
    private var router : RouterProtocol
    
    weak var delegate : StoreViewDelegate?
    private var dataSource : StoreViewDataSource?
    
    private var store: Store?
    private var basket: Basket?
    private var applicationTheme: ColorTheme
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    required init(withRouter router: Router = Router.singleton, withBasket basket: Basket = Basket(defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY), applicationTheme: ColorTheme = .blue)
    {
        self.router = router
        self.basket = basket
        self.applicationTheme = applicationTheme
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    private func initDefaultStore()
    {
        guard let basket = self.basket else {
            return
        }
        
        self.store = Store(withCars: [], defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY)
        
        self.dataSource = StoreViewDataSource(viewModel: StorePresenter.transformToStoreViewModel(basket: basket, store: self.store!))
    }
}

// MARK: - Delegate
extension StorePresenter : StorePresenterDelegate
{
    func loadStore()
    {
        // Set the default values fsor the store
        initDefaultStore()
        
        // Fetch additional data for the cars
        fetchCarStoreData(handler: {[weak self] (data, error) -> Void in
            if let presenter = self
            {
                if let cars = data
                {
                    if let oldStore = presenter.store
                    {
                        presenter.store = Store(withCars: cars, defaultCurrency: oldStore.defaultCurrency, currencies: oldStore.currencies)
                        
                        if let basket = presenter.basket
                        {
                            presenter.dataSource = StoreViewDataSource(viewModel: StorePresenter.transformToStoreViewModel(basket: basket, store: presenter.store!))
                        }
                        
                        presenter.delegate?.updateStore(dataSource: presenter.dataSource)
                    }
                }
                else
                {
                    if let err = error
                    {
                        print("StorePresenter: network fetch failed! Error: \(err.rawValue)")
                    }
                    
                    presenter.delegate?.updateStore(dataSource: self?.dataSource)
                }
            }
        })
        
        // Fetch additional data for the currencies
        fetchCurrencyData(handler: {[weak self] (data, error) -> Void in
            if let presenter = self
            {
                if let currencies = data
                {
                    if let oldStore = presenter.store
                    {
                        presenter.store = Store(withCars: oldStore.cars, defaultCurrency: oldStore.defaultCurrency, currencies: currencies)
                        
                        if let basket = presenter.basket
                        {
                            presenter.dataSource = StoreViewDataSource(viewModel: StorePresenter.transformToStoreViewModel(basket: basket, store: presenter.store!))
                        }
                        
                        presenter.delegate?.updateStore(dataSource: presenter.dataSource)
                    }
                }
                else
                {
                    if let err = error
                    {
                        print("StorePresenter: network fetch failed! Error: \(err.rawValue)")
                    }
                    
                    presenter.delegate?.updateStore(dataSource: self?.dataSource)
                }
            }
        })
        
        // Update theme
        delegate?.updateTheme(theme: applicationTheme)
    }
    
    func clearBasketCars()
    {
        guard let _ = self.basket else {
            return
        }
        
        self.basket!.cars = []
        
        // Construct the view model and pass it to view delegate
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!, applicationTheme: applicationTheme)
        {
            self.delegate?.updateBasket(viewModel: viewModel)
        }
    }
    
    func setBasketCars(cars: [Car])
    {
        guard let _ = self.basket else {
            return
        }
        
        self.basket!.cars = cars
        
        // Construct the view model and pass it to view delegate
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!, applicationTheme: applicationTheme)
        {
            self.delegate?.updateBasket(viewModel: viewModel)
        }
    }
    
    func addCarToBasket(car: Car)
    {
        guard let _ = self.basket else {
            return
        }
        
        // Update model by adding the car
        basket!.add(car)
        
        // Construct the view model and pass it to view delegate
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!, applicationTheme: applicationTheme)
        {
            self.delegate?.updateBasket(viewModel: viewModel)
        }
    }
    
    func removeCarFromBasket(car: Car)
    {
        guard let _ = self.basket else {
            return
        }
        
        // Update model by removing the car
        basket!.remove(car)
        
        // Construct the view model and pass it to view delegate
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!, applicationTheme: applicationTheme)
        {
            self.delegate?.updateBasket(viewModel: viewModel)
        }
    }
    
    func setDefaultCurrency(defaultCurrency: StoreCurrency)
    {
        basket?.defaultCurrency = defaultCurrency
        store?.defaultCurrency = defaultCurrency
        
        if let store = self.store
        {
            if let basket = self.basket
            {
                self.dataSource = StoreViewDataSource(viewModel: StorePresenter.transformToStoreViewModel(basket: basket, store: store))
                self.delegate?.updateStore(dataSource: self.dataSource)
            }
        }
        
        if let basket = self.basket
        {
            self.delegate?.updateBasket(viewModel: StorePresenter.transformToBasketViewModel(basket: basket, applicationTheme: applicationTheme))
        }
        
        print("StorePresenter: application default currency has been changed to \(defaultCurrency.name.rawValue)")
    }
    
    func setApplicationTheme(applicationTheme: ColorTheme)
    {
        self.applicationTheme = applicationTheme
        
        delegate?.updateTheme(theme: applicationTheme)
        
        print("StorePresenter: application theme has been changed to \(applicationTheme.rawValue)")
    }
    
    func goToProductScene(atTableIndex index: IndexPath)
    {
        guard let store = self.store else {
            return
        }
        
        if (0..<store.cars.count).contains(index.row)
        {
            router.goToStoreProduct(withCar: store.cars[index.row], defaultCurrency: store.defaultCurrency)
        }
    }
    
    func goToBasket()
    {
        guard let basket = self.basket else {
            return
        }
        
        router.goToBasket(withBasket: basket)
    }
    
    func goToSettings()
    {
        guard let store = self.store else {
            return
        }
        
        router.goToSettings(defaultCurrency: store.defaultCurrency, currencies: store.currencies, applicationTheme: applicationTheme)
    }
}

// MARK: - Transformations
extension StorePresenter
{
    class func transformToBasketViewModel(basket: Basket, applicationTheme: ColorTheme) -> BasketViewModel?
    {
        var carDescriptions: [String] = []
        
        for car in basket.cars
        {
            // All car descriptions must be successfully built, otherwise this function does nothing
            if let description = StorePresenter.transformCarToCarDescription(car: car, defaultCurrency: basket.defaultCurrency)
            {
                carDescriptions.append(description)
            }
            else
            {
                return nil
            }
        }
        
        if let totalPrice = basket.getTotalPriceWithSymbol(forCurrency: basket.defaultCurrency)
        {
            return BasketViewModel(carDescriptions: carDescriptions, totalPrice: totalPrice)
        }
        
        return nil
    }
    
    class func transformCarToCarDescription(car: Car, defaultCurrency: StoreCurrency) -> String?
    {
        if let price = car.getPriceWithSymbol(forCurrency: defaultCurrency)
        {
            return String("\(car.manufacturer) \(car.model) for \(price)")
        }
        
        return nil
    }
    
    class func transformToStoreViewModel(basket: Basket, store: Store) -> StoreViewModel?
    {
        var carDescriptions : [String] = []
        
        for car in store.cars
        {
            // All car descriptions must be successfully built, otherwise a nil view model will be returned
            if let description = StorePresenter.transformCarToCarDescription(car: car, defaultCurrency: basket.defaultCurrency)
            {
                carDescriptions.append(description)
            }
            else
            {
                return nil
            }
        }
        
        if let totalPrice = basket.getTotalPriceWithSymbol(forCurrency: basket.defaultCurrency)
        {
            let basketDescription = String("Basket: \(carDescriptions.count) cars, \(totalPrice) total")
            
            return StoreViewModel(carDescriptions: carDescriptions, basketDescription: basketDescription)
        }
        
        return nil
    }
}

// MARK: - Networking - currency data
extension StorePresenter
{
    static let CURRENCY_HTTP_TIMEOUT : Double = 5
    
    class func getCurrencyAPIKey() -> String
    {
        return "2a40b989f394219b9235743c7d8cbd15"
    }
    
    class func getCurrencyAPIURL() -> URL?
    {
        return URL(string: "http://apilayer.net/api/live?access_key=" + StorePresenter.getCurrencyAPIKey())
    }
    
    func fetchCurrencyData(handler: @escaping([StoreCurrency]?, NetworkError?)->Void)
    {
        guard let url = StorePresenter.getCurrencyAPIURL() else
        {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: StorePresenter.CURRENCY_HTTP_TIMEOUT)
        
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

// MARK: - Networking - car store data
extension StorePresenter
{
    static let CAR_STORE_HTTP_TIMEOUT : Double = 5
    
    class func getCarStoreAPIURL() -> URL?
    {
        return URL(string: "https://www.carqueryapi.com/api/0.3/?cmd=getTrims&year=2015")
    }
    
    func fetchCarStoreData(handler: @escaping([Car]?, NetworkError?)->Void)
    {
        guard let url = StorePresenter.getCarStoreAPIURL() else
        {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: StorePresenter.CAR_STORE_HTTP_TIMEOUT)
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let json = data
            {
                do
                {
                    let result = try Car.initCars(withJSON: json)
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
