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
        self.customView = self.view as? BasketView
        self.customView?.delegate = self
        
        navigationItem.title = "Basket"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(actionCheckout(_:)))
    }
}

// MARK: - Table selection action
extension BasketViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("BasketViewController: selecting a basket product from the table")
        
        if let selectedRow = self.customView?.indexPathForSelectedRow
        {
            presenter?.goToProductScene(atTableIndex: selectedRow)
        }
    }
}

// MARK: - Delegate
extension BasketViewController : BasketViewDelegate
{
    func update(viewModel: BasketViewModel?, dataSource: BasketViewDataSource?)
    {
        self.customView?.update(viewModel: viewModel, dataSource: dataSource)
    }
    
    func deactivateCheckout()
    {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

// MARK: - Navigation item button actions
extension BasketViewController {
    @objc
    func actionCheckout(_ sender: Any)
    {
        presenter?.goToCheckout()
    }
}
