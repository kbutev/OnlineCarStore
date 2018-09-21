//
//  BasketProductPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 21.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol BasketProductViewDelegate: AnyObject
{
    func update(model: BasketProductViewModel)
}

protocol BasketProductPresenterDelegate: AnyObject
{
    func updateInterface()
    func removeCar()
}

class BasketProductPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: BasketProductViewDelegate?
    
    private var basket: Basket?
    private let car: Car
    private let viewModel: BasketProductViewModel
    
    required init(withRouter router: Router = Router.singleton, basket: Basket, car: Car)
    {
        self.router = router
        
        self.basket = basket
        self.car = car
        
        self.viewModel = BasketProductViewModel(manufacturer: car.manufacturer,
                                                model: car.model,
                                                description: car.description,
                                                topSpeed: String("\(car.topSpeed)km/h"),
                                                price: car.getPriceWithSymbol(forCurrency: basket.defaultCurrency),
                                                imageURL: car.imageURL)
    }
}

// MARK: - Delegate
extension BasketProductPresenter : BasketProductPresenterDelegate
{
    func updateInterface()
    {
        self.delegate?.update(model: viewModel)
    }
    
    func removeCar()
    {
        DispatchQueue.main.async {
            if var basket = self.basket
            {
                basket.remove(self.car)
                
                self.router.goBackFromBasketProduct(withBasket: basket)
            }
        }
    }
}
