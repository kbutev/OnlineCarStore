//
//  CheckoutView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class CheckoutView : UIView
{
    @IBOutlet private weak var labelBasketDescription: UILabel!
    
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
        let layoutGuide = self.safeAreaLayoutGuide
        
        labelBasketDescription.translatesAutoresizingMaskIntoConstraints = false
        labelBasketDescription.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.8)
        labelBasketDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelBasketDescription.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 15.0).isActive = true
    }
    
    func update(viewModel: CheckoutViewModel?)
    {
        DispatchQueue.main.async {
            self.labelBasketDescription.text = viewModel?.basketDescription
        }
        
    }
}
