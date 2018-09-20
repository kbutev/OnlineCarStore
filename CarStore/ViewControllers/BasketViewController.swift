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
    
    init(withPresenter presenter: BasketPresenter)
    {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        presenter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initInterface()
        
        presenter?.update()
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
        navigationItem.title = "Basket"
        
        self.customView = self.view as? BasketView
    }
}

// MARK: - Delegate
extension BasketViewController : BasketViewDelegate
{
    func update(viewModel: BasketViewModel?, dataSource: BasketViewDataSource?)
    {
        self.customView?.update(viewModel: viewModel, dataSource: dataSource)
    }
}
