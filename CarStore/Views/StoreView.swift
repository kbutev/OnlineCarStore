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
    private let model : StoreViewModel?
    
    init(model : StoreViewModel?)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreView.CELL_IDENTIFIER, for: indexPath)
        
        if let carName = model?.carDescriptions[indexPath.row]
        {
            cell.textLabel!.text = carName
        }
        
        return cell
    }
}

class StoreView : UITableView
{
    static let CELL_IDENTIFIER = "Product"
    
    override init(frame: CGRect, style: UITableView.Style)
    {
        super.init(frame: frame, style: style)
        register(UITableViewCell.self, forCellReuseIdentifier: StoreView.CELL_IDENTIFIER)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        register(UITableViewCell.self, forCellReuseIdentifier: StoreView.CELL_IDENTIFIER)
    }
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    private func setup()
    {
        guard let parent = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 1).isActive = true
        heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 1).isActive = true
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
