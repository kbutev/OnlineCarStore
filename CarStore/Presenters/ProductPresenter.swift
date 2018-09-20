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
    func buyCarAndGoBack(car: Car)
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
    
    let car: Car
    let defaultCurrency: StoreCurrency
    let viewModel: ProductViewModel
    
    required init(withRouter router: Router = Router.singleton, car: Car, defaultCurrency: StoreCurrency)
    {
        self.router = router
        
        self.car = car
        self.defaultCurrency = defaultCurrency
        
        self.viewModel = ProductViewModel(manufacturer: car.manufacturer,
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
        self.delegate?.update(model: viewModel)
    }
    
    func buyCar()
    {
        router.goBackToStore(withPurchasedCar: car)
    }
}
