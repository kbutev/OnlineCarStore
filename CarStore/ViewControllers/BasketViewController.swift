//
//  BasketViewController.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class BasketViewController : UIViewController
{
    private var customView: BasketView?
    
    private var presenter: BasketPresenterDelegate? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initInterface()
        
        initPresenter()
        
        self.presenter?.loadStore()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    private func initInterface()
    {
        self.customView = self.view as? BasketView
    }
    
    private func initPresenter()
    {
        
    }
}
