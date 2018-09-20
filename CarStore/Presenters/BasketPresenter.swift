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
}

protocol BasketPresenterDelegate: AnyObject
{
    func update()
}

class BasketPresenter
{
    private var router : RouterProtocol
    
    weak var delegate: BasketViewDelegate?
    private var dataSource : BasketViewDataSource?
    
    private var viewModel: BasketViewModel?
    
    required init(withRouter router: Router = Router.singleton, basket: BasketViewModel)
    {
        self.router = router
        self.viewModel = basket
    }
}

// MARK: - Delegate
extension BasketPresenter : BasketPresenterDelegate
{
    func update()
    {
        self.dataSource = BasketViewDataSource(model: viewModel)
        self.delegate?.update(viewModel: viewModel, dataSource: self.dataSource)
    }
}
