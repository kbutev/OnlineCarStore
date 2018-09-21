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
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    required init(withRouter router: Router = Router.singleton, withBasket basket: Basket = Basket(defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY))
    {
        self.router = router
        self.basket = basket
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    private func initDefaultStore()
    {
        let a = Car(manufacturer: "BMW", model: "x6", description: "The X6 marks BMW's first use of its new Dynamic Performance Control system, which works in unison with xDrive all-wheel drive, both being standard on the X6. DPC is a drivetrain and chassis control system that works to regulate traction and especially correct over- and understeer by actively spreading out drive forces across the rear axle.", topSpeed: 270, price: 20000, imageURL: "https://www.bmw.ca/content/dam/bmw/common/all-models/6-series/gran-turismo/2017/navigation/bmw-6series-granturismo-modelfinder-stage2-890x501.png")
        let b = Car(manufacturer: "Mercedes", model: "w203", description: "Though originally available as a sedan and a station wagon, the W203 series in 2000 debuted a fastback coupé (SportCoupé) version that, when facelifted, became the Mercedes-Benz CLC-Class. The CLC-Class remained in production until 2011 when it was replaced by a new W204 C-Class coupé for the 2012 model year.", topSpeed: 250, price: 8000, imageURL: "https://www.mercedes-benz.co.za/passengercars/_jcr_content/image.MQ6.2.2x.20180511103036.png")
        let c = Car(manufacturer: "Toyota", model: "rav4", description: "The vehicle was designed for consumers wanting a vehicle that had most of the benefits of SUVs, such as increased cargo room, higher visibility, and the option of full-time four-wheel drive, along with the maneuverability and fuel economy of a compact car. Although not all RAV4s are four-wheel-drive, RAV4 stands for \"Recreational Activity Vehicle: 4-wheel drive\".", topSpeed: 200, price: 12000, imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2eheIR9WIlKC_7KIWJWON5umqZ0iiSk7uNoG_UhO_sh_vh2EXag")
        let d = Car(manufacturer: "Dodge", model: "FCA US", description: "Ram trucks have been named Motor Trend magazine's Truck of the Year five times; the second-generation Ram won the award in 1994, the third-generation Ram Heavy Duty won the award in 2003, the fourth-generation Ram Heavy Duty won in 2010 and the fourth-generation Ram 1500 won in 2013 and 2014.", topSpeed: 120, price: 6000, imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Ram_1500_Genf_2018.jpg/1920px-Ram_1500_Genf_2018.jpg")
        
        self.store = Store(withCars: [a, b, c, d], defaultCurrency: CurrencyConstants.DEFAULT_CURRENCY)
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
                if let oldStore = self.store
                {
                    self.store = Store(withCars: oldStore.cars, defaultCurrency: oldStore.defaultCurrency, currencies: currencies)
                    
                    if let basket = self.basket
                    {
                        self.dataSource = StoreViewDataSource(viewModel: StorePresenter.transformToStoreViewModel(basket: basket, store: self.store!))
                    }
                }
                
                self.delegate?.updateStore(dataSource: self.dataSource)
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
    
    func clearBasketCars()
    {
        guard let _ = self.basket else {
            return
        }
        
        self.basket!.cars = []
        
        // Construct the view model and pass it to view delegate
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!)
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
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!)
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
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!)
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
        if let viewModel = StorePresenter.transformToBasketViewModel(basket: basket!)
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
            self.delegate?.updateBasket(viewModel: StorePresenter.transformToBasketViewModel(basket: basket))
        }
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
        
        router.goToSettings(defaultCurrency: store.defaultCurrency, currencies: store.currencies)
    }
}

// MARK: - Transformations
extension StorePresenter
{
    class func transformToBasketViewModel(basket: Basket) -> BasketViewModel?
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
