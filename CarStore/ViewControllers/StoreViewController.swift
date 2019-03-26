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
    private let window: UIWindow?
    
    private var customView: StoreView?
    
    private var presenter: StorePresenterDelegate? = nil
    
    init(withWindow window: UIWindow?, withPresenter presenter: StorePresenter)
    {
        self.window = window
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        presenter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.window = nil
        
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
        self.customView = self.view as? StoreView
        self.customView?.delegate = self
        
        navigationItem.title = "Car store"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Basket", style: .plain, target: self, action: #selector(actionBasket(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(actionSettings(_:)))
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
    func updateTheme(theme: ColorTheme?)
    {
        self.window?.tintColor = theme?.getUIColor()
    }
    
    func updateStore(dataSource: StoreViewDataSource?)
    {
        self.customView?.updateStore(dataSource: dataSource)
    }
    
    func updateBasket(viewModel: BasketViewModel?)
    {
        self.customView?.updateBasket(viewModel: viewModel)
    }
    
    func sendErrorMessage(title: String, message: String)
    {
        if navigationController?.topViewController == self
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10, execute: {
            self.presenter?.loadStore()
        })
    }
}
