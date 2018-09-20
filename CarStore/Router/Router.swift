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
    func goBackToStore(withPurchasedCar car: Car)
}

class Router
{
    static let singleton = Router()
    
    private weak var window: UIWindow?
    
    private var navigationController: UINavigationController?
    
    private var defaultViewController: StoreViewDelegate?
    private var defaultPresenter: StorePresenterDelegate?
    
    init()
    {
        
    }
    
    func configurate(window: UIWindow?)
    {
        self.window = window
        
        // Create navigation controller as root controller
        self.navigationController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        window!.rootViewController = self.navigationController
        
        // Create default presenter
        let presenter = StorePresenter(withRouter: self)
        self.defaultPresenter = presenter
        
        // Create default controller and push it to navigation as a root controller
        let viewController = StoreViewController(withPresenter: presenter)
        self.defaultViewController = viewController
        self.navigationController?.pushViewController(viewController, animated: false)
        
        // Activate window
        window!.makeKeyAndVisible()
    }
}

// MARK: - Protocol
extension Router : RouterProtocol
{
    func goToStoreProduct(withCar car: Car, defaultCurrency: StoreCurrency)
    {
        let destination = ProductViewController(withPresenter: ProductPresenter(withRouter:self, car: car, defaultCurrency: defaultCurrency))
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func goBackToStore(withPurchasedCar car: Car)
    {
        self.defaultPresenter?.addCarToBasket(car: car)
        
        self.navigationController?.popViewController(animated: true)
    }
}
