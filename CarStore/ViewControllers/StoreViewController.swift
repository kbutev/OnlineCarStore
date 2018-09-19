//
//  StoreViewController.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class StoreViewController : UIViewController
{
    private var customView: StoreView?
    
    private var presenter: StorePresenterDelegate? = nil
    
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
        self.customView = self.view as? StoreView
    }
    
    private func initPresenter()
    {
        let presenter = StorePresenter()
        self.presenter = presenter
        presenter.delegate = self
    }
}

// MARK: - Delegate
extension StoreViewController : StoreViewDelegate
{
    func update(dataSource: StoreViewDataSource?)
    {
        DispatchQueue.main.async {
            self.customView?.dataSource = dataSource
            self.customView?.reloadData()
        }
    }
}
