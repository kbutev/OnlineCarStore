//
//  BasketView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class BasketViewDataSource : NSObject, UITableViewDataSource
{
    private let model : BasketViewModel?
    
    init(model : BasketViewModel?)
    {
        self.model = model
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.model
        {
            return model.carDescriptions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketView.CELL_IDENTIFIER, for: indexPath)
        
        if let carName = model?.carDescriptions[indexPath.row]
        {
            cell.textLabel!.text = carName
        }
        
        return cell
    }
}

class BasketView : UIView
{
    static let CELL_IDENTIFIER = "Item"
    
    @IBOutlet private weak var table: UITableView!
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var toolbarItem: UIBarButtonItem!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    private func setup()
    {
        table.register(UITableViewCell.self, forCellReuseIdentifier: BasketView.CELL_IDENTIFIER)
        table.register(UITableViewCell.self, forCellReuseIdentifier: BasketView.CELL_IDENTIFIER)
        
        let layoutGuide = self.safeAreaLayoutGuide
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        table.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0).isActive = true
        
        self.bringSubviewToFront(toolbar)
    }
}

// MARK: - Methods used by the view controller to manipulate the interface
extension BasketView
{
    func update(viewModel: BasketViewModel?, dataSource: BasketViewDataSource?)
    {
        DispatchQueue.main.async {
            self.table.dataSource = dataSource
            self.table.reloadData()
            
            if let model = viewModel
            {
                if let totalPrice = model.totalPrice
                {
                    if model.carDescriptions.count != 0
                    {
                        self.toolbarItem.title = String("Basket: \(model.carDescriptions.count) cars, \(totalPrice) total")
                    }
                    else
                    {
                        self.toolbarItem.title = String("Empty basket")
                    }
                }
            }
        }
    }
}

// MARK: - Table
extension BasketView
{
    var delegate : UITableViewDelegate? {
        set {
            table.delegate = newValue
        }
        
        get {
            return table.delegate
        }
    }
    
    var dataSource : UITableViewDataSource? {
        set {
            table.dataSource = newValue
        }
        
        get {
            return table.dataSource
        }
    }
    
    var indexPathForSelectedRow : IndexPath? {
        get {
            return table.indexPathForSelectedRow
        }
    }
    
    func reloadData()
    {
        table.reloadData()
    }
}
