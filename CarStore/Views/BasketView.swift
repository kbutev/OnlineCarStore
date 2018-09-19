//
//  BasketView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class BasketView : UITableView
{
    static let CELL_IDENTIFIER = "Item"
    
    override init(frame: CGRect, style: UITableView.Style)
    {
        super.init(frame: frame, style: style)
        register(UITableViewCell.self, forCellReuseIdentifier: BasketView.CELL_IDENTIFIER)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        register(UITableViewCell.self, forCellReuseIdentifier: BasketView.CELL_IDENTIFIER)
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
