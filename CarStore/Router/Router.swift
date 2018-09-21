//
//  Router.swift
//  CarStore
//
//  Created by Kristiyan Butev on 20.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

protocol RouterProtocol : AnyObject
{
    func goToStoreProduct(withCar car: Car, defaultCurrency: StoreCurrency)
    func goBackFromStoreProduct(withPurchasedCar car: Car)
    
    func goToBasket(withBasket basket: Basket)
    func goBackFromBasketProduct(withBasket basket: Basket)
    func goToBasketProduct(withBasket basket: Basket, withCar car: Car)
    
    func goToCheckout(withBasket basket: Basket)
    
    func goBackAndBuyCars()
    
    func goToSettings(defaultCurrency: StoreCurrency, currencies: [StoreCurrency])
    func goBackFromSettings(selectedCurrency: StoreCurrency)
}

class Router
{
    static let singleton = Router()
    
    private weak var window: UIWindow?
    
    private weak var defaultViewController: StoreViewDelegate?
    private weak var defaultPresenter: StorePresenterDelegate?
    
    init()
    {
        
    }
    
    func configurate(window: UIWindow?)
    {
        self.window = window
        
        // Create navigation controller as root controller
        let navigationController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        window!.rootViewController = navigationController
        
        // Create default presenter
        let presenter = StorePresenter(withRouter: self)
        self.defaultPresenter = presenter
        
        // Create default controller and push it to navigation as a root controller
        let viewController = StoreViewController(withPresenter: presenter)
        self.defaultViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
        
        // Activate window
        window!.makeKeyAndVisible()
    }
    
    func rootNavigationController() -> UINavigationController?
    {
        return window?.rootViewController as? UINavigationController
    }
}

// MARK: - Protocol
extension Router : RouterProtocol
{
    func goToStoreProduct(withCar car: Car, defaultCurrency: StoreCurrency)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        let destination = ProductViewController(withPresenter: ProductPresenter(withRouter:self, car: car, defaultCurrency: defaultCurrency))
        
        navigationController.pushViewController(destination, animated: true)
    }
    
    func goBackFromStoreProduct()
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        navigationController.popViewController(animated: true)
    }
    
    func goBackFromStoreProduct(withPurchasedCar car: Car)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        self.defaultPresenter?.addCarToBasket(car: car)
        
        navigationController.popViewController(animated: true)
    }
    
    func goToBasket(withBasket basket: Basket)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        let destination = BasketViewController(withPresenter: BasketPresenter(withRouter:self, basket: basket))
        
        navigationController.pushViewController(destination, animated: true)
    }
    
    func goToBasketProduct(withBasket basket: Basket, withCar car: Car)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        let destination = BasketProductViewController(withPresenter: BasketProductPresenter(withRouter:self, basket: basket, car: car))
        
        navigationController.pushViewController(destination, animated: true)
    }
    
    func goBackFromBasketProduct(withBasket basket: Basket)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        navigationController.popViewController(animated: true)
        navigationController.popViewController(animated: false)
        
        defaultPresenter?.setBasketCars(cars: basket.cars)
        
        let destination = BasketViewController(withPresenter: BasketPresenter(withRouter:self, basket: basket))
        
        navigationController.pushViewController(destination, animated: false)
    }
    
    func goToCheckout(withBasket basket: Basket)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        let destination = CheckoutViewController(withPresenter: CheckoutPresenter(withRouter:self, basket: basket))
        
        navigationController.pushViewController(destination, animated: true)
    }
    
    func goBackAndBuyCars()
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        navigationController.popViewController(animated: false)
        navigationController.popViewController(animated: true)
        
        defaultPresenter?.clearBasketCars()
    }
    
    func goToSettings(defaultCurrency: StoreCurrency, currencies: [StoreCurrency])
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        let destination = SettingsViewController(withPresenter: SettingsPresenter(withRouter:self, defaultCurrency: defaultCurrency, currencies: currencies))
        
        navigationController.pushViewController(destination, animated: true)
    }
    
    func goBackFromSettings(selectedCurrency: StoreCurrency)
    {
        guard let navigationController = rootNavigationController() else {
            return
        }
        
        defaultPresenter?.setDefaultCurrency(defaultCurrency: selectedCurrency)
        
        navigationController.popViewController(animated: true)
    }
}
