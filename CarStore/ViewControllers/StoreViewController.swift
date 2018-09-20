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
    
    init(withPresenter presenter: StorePresenter)
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
        navigationItem.title = "Pick car"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Basket", style: .plain, target: self, action: #selector(actionBasket(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(actionSettings(_:)))
        
        self.customView = self.view as? StoreView
        self.customView?.delegate = self
    }
}

// MARK: - Table selection action
extension StoreViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("StoreViewController: selecting a product from the table")
        
        if let selectedRow = self.customView?.indexPathForSelectedRow
        {
            presenter?.goToProductScene(atTableIndex: selectedRow)
        }
    }
}

// MARK: - Navigation item button actions
extension StoreViewController {
    @objc
    func actionBasket(_ sender: Any)
    {
        presenter?.goToBasket()
    }
    
    @objc
    func actionSettings(_ sender: Any)
    {
        presenter?.goToSettings()
    }
}

// MARK: - Delegate
extension StoreViewController : StoreViewDelegate
{
    func updateStore(dataSource: StoreViewDataSource?)
    {
        self.customView?.updateStore(dataSource: dataSource)
    }
    
    func updateBasket(basket: BasketViewModel)
    {
        self.customView?.updateBasket(model: basket)
    }
}
