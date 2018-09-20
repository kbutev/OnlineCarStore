//
//  ProductViewController.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class ProductViewController : UIViewController
{
    private var customView: ProductView?
    
    private var presenter: ProductPresenterDelegate? = nil
    
    init(withPresenter presenter: ProductPresenter)
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
        
        self.presenter?.updateInterface()
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
        self.customView = self.view as? ProductView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: #selector(actionBuy(_:)))
    }
}

// MARK: - Delegate
extension ProductViewController : ProductViewDelegate
{
    func update(model: ProductViewModel)
    {
        DispatchQueue.main.async {
            if model.manufacturer != nil && model.model != nil
            {
                self.navigationItem.title = String("\(model.manufacturer!) \(model.model!)")
            }
            
            self.customView?.update(model: model)
        }
    }
    
    func buyCarAndGoBack(car: Car)
    {
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Navigation right button action
extension ProductViewController
{
    @objc
    func actionBuy(_ sender: Any)
    {
        presenter?.buyCar()
    }
}
