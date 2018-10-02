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
    func update(viewModel: ProductViewModel?)
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
                                engine: car.engine,
                                price: car.getPriceWithSymbol(forCurrency: defaultCurrency),
                                imageURL: car.imageURL)
    }
}

// MARK: - Delegate
extension ProductPresenter : ProductPresenterDelegate
{
    func updateInterface()
    {
        self.delegate?.update(viewModel: viewModel)
    }
    
    func buyCar()
    {
        router.goBackFromStoreProduct(withPurchasedCar: car)
    }
}
