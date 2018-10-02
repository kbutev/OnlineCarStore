//
//  StoreView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class StoreViewDataSource : NSObject, UITableViewDataSource
{
    private let viewModel : StoreViewModel?
    
    init(viewModel : StoreViewModel?)
    {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.viewModel
        {
            return model.carDescriptions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreView.CELL_IDENTIFIER, for: indexPath)
        
        if let carName = viewModel?.carDescriptions[indexPath.row]
        {
            cell.textLabel!.text = carName
        }
        
        return cell
    }
}

class StoreView : UIView
{
    static let CELL_IDENTIFIER = "Product"
    
    @IBOutlet private weak var table: UITableView!
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarItem: UIBarButtonItem!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    func setup()
    {
        table.register(UITableViewCell.self, forCellReuseIdentifier: StoreView.CELL_IDENTIFIER)
        
        let layoutGuide = safeAreaLayoutGuide
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        table.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0.0).isActive = true
        table.bottomAnchor.constraint(equalTo: toolbar.topAnchor, constant: 0.0).isActive = true
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0).isActive = true
        toolbar.items?.first?.tintColor = self.window?.tintColor
        
        bringSubviewToFront(toolbar)
    }
}

// MARK: - Methods used by the view controller to manipulate the interface
extension StoreView
{
    func updateStore(dataSource: StoreViewDataSource?)
    {
        DispatchQueue.main.async {
            self.table.dataSource = dataSource
            self.table.reloadData()
        }
    }
    
    func updateBasket(viewModel: BasketViewModel?)
    {
        guard let model = viewModel else {
            return
        }
        
        if let totalPrice = model.totalPrice
        {
            DispatchQueue.main.async {
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

// MARK: - Table
extension StoreView
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

// MARK: - Factories
extension StoreView
{
    class func create(owner: Any) -> StoreView?
    {
        let bundle = Bundle.main
        let nibName = String(describing: StoreView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: owner, options: nil).first as? StoreView
    }
}
