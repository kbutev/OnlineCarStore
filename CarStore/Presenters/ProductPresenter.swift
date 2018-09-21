//
//  ProductPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol ProductViewDelegate: AnyObject
{
    func update(model: ProductViewModel)
}

protocol ProductPresenterDelegate: AnyObject
{
    func updateInterface()
    func buyCar()
}

class ProductPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: ProductViewDelegate?
    
    private let car: Car
    private let defaultCurrency: StoreCurrency
    private let viewModel: ProductViewModel?
    
    required init(withRouter router: Router = Router.singleton, car: Car, defaultCurrency: StoreCurrency)
    {
        self.router = router
        
        self.car = car
        self.defaultCurrency = defaultCurrency
        
        self.viewModel = ProductPresenter.transformToBasketViewModel(car: car, defaultCurrency: defaultCurrency)
    }
}

// MARK: - Transformations
extension ProductPresenter
{
    class func transformToBasketViewModel(car: Car, defaultCurrency: StoreCurrency) -> ProductViewModel?
    {
        return ProductViewModel(manufacturer: car.manufacturer,
                                model: car.model,
                                description: car.description,
                                topSpeed: String("\(car.topSpeed)km/h"),
                                price: car.getPriceWithSymbol(forCurrency: defaultCurrency),
                                imageURL: car.imageURL)
    }
}

// MARK: - Delegate
extension ProductPresenter : ProductPresenterDelegate
{
    func updateInterface()
    {
        if let model = viewModel
        {
            self.delegate?.update(model: model)
        }
    }
    
    func buyCar()
    {
        router.goBackFromStoreProduct(withPurchasedCar: car)
    }
}
