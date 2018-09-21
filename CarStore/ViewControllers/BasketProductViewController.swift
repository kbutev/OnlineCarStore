//
//  BasketProductViewController.swift
//  CarStore
//
//  Created by Kristiyan Butev on 21.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class BasketProductViewController : UIViewController
{
    private var customView: BasketProductView?
    
    private var presenter: BasketProductPresenterDelegate? = nil
    
    init(withPresenter presenter: BasketProductPresenter)
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
        
        self.presenter?.update()
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
        self.customView = self.view as? BasketProductView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(actionRemove(_:)))
    }
}

// MARK: - Delegate
extension BasketProductViewController : BasketProductViewDelegate
{
    func update(viewModel: BasketProductViewModel?)
    {
        DispatchQueue.main.async {
            if let model = viewModel
            {
                if model.manufacturer != nil && model.model != nil
                {
                    self.navigationItem.title = String("\(model.manufacturer!) \(model.model!)")
                }
            }
            
            self.customView?.update(viewModel: viewModel)
        }
    }
    
    func removeCarAndGoBack(car: Car)
    {
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Navigation right button action
extension BasketProductViewController
{
    @objc
    func actionRemove(_ sender: Any)
    {
        presenter?.removeCar()
    }
}
