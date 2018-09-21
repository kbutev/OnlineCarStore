//
//  BasketPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol BasketViewDelegate: AnyObject
{
    func update(viewModel: BasketViewModel?, dataSource: BasketViewDataSource?)
    
    func deactivateCheckout()
}

protocol BasketPresenterDelegate: AnyObject
{
    func update()
    
    func goToProductScene(atTableIndex index: IndexPath)
    
    func goToCheckout()
}

class BasketPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: BasketViewDelegate?
    private var dataSource : BasketViewDataSource?
    
    private var basket: Basket?
    private let viewModel: BasketViewModel?
    
    required init(withRouter router: Router = Router.singleton, basket: Basket)
    {
        self.router = router
        self.basket = basket
        self.viewModel = BasketPresenter.transformToBasketViewModel(basket: basket)
    }
}

// MARK: - Transformations
extension BasketPresenter
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
}

// MARK: - Delegate
extension BasketPresenter : BasketPresenterDelegate
{
    func update()
    {
        DispatchQueue.main.async {
            self.dataSource = BasketViewDataSource(model: self.viewModel)
            self.delegate?.update(viewModel: self.viewModel, dataSource: self.dataSource)
            
            if let basket = self.basket
            {
                if basket.cars.count == 0
                {
                    self.delegate?.deactivateCheckout()
                }
            }
        }
    }
    
    func goToProductScene(atTableIndex index: IndexPath)
    {
        guard let basket = self.basket else {
            return
        }
        
        if (0..<basket.cars.count).contains(index.row)
        {
            router.goToBasketProduct(withBasket: basket, withCar: basket.cars[index.row])
        }
    }
    
    func goToCheckout()
    {
        guard let basket = self.basket else {
            return
        }
        
        router.goToCheckout(withBasket: basket)
    }
}
