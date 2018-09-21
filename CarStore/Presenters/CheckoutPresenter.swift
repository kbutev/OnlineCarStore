//
//  CheckoutPresenter.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol CheckoutViewDelegate: AnyObject
{
    func update(viewModel: CheckoutViewModel?)
}

protocol CheckoutPresenterDelegate: AnyObject
{
    func update()
    
    func buyCars()
}

class CheckoutPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: CheckoutViewDelegate?
    
    private var basket: Basket?
    private var viewModel: CheckoutViewModel?
    
    required init(withRouter router: Router = Router.singleton, basket: Basket)
    {
        self.router = router
        self.basket = basket
        
        self.viewModel = CheckoutPresenter.transformToCheckoutViewModel(basket: basket)
    }
}

// MARK: - Transformations
extension CheckoutPresenter
{
    class func transformToCheckoutViewModel(basket: Basket) -> CheckoutViewModel?
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
            let basketDescription = String("Basket: \(carDescriptions.count) cars, \(totalPrice) total")
            
            return CheckoutViewModel(carDescriptions: carDescriptions, basketDescription: basketDescription)
        }
        
        return nil
    }
}

// MARK: - Delegate
extension CheckoutPresenter : CheckoutPresenterDelegate
{
    func update()
    {
        delegate?.update(viewModel: viewModel)
    }
    
    func buyCars()
    {
        router.goBackAndBuyCars()
    }
}
