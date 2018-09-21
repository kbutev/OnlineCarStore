//
//  BasketProductView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 21.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class BasketProductView : UIView
{
    @IBOutlet private weak var imagePicture: UIImageView!
    @IBOutlet private weak var labelPrice: UILabel!
    @IBOutlet private weak var labelTopSpeed: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    private func setup()
    {
        let layoutGuide = self.safeAreaLayoutGuide
        
        imagePicture.translatesAutoresizingMaskIntoConstraints = false
        imagePicture.widthAnchor.constraint(equalToConstant: 128).isActive = true
        imagePicture.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imagePicture.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10.0).isActive = true
        imagePicture.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 25.0).isActive = true
        
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.widthAnchor.constraint(equalToConstant: 196).isActive = true
        labelPrice.heightAnchor.constraint(equalToConstant: 32).isActive = true
        labelPrice.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 10.0).isActive = true
        labelPrice.leadingAnchor.constraint(equalTo: imagePicture.trailingAnchor, constant: 2.0).isActive = true
        
        labelTopSpeed.translatesAutoresizingMaskIntoConstraints = false
        labelTopSpeed.widthAnchor.constraint(equalToConstant: 196).isActive = true
        labelTopSpeed.heightAnchor.constraint(equalToConstant: 32).isActive = true
        labelTopSpeed.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 10.0).isActive = true
        labelTopSpeed.leadingAnchor.constraint(equalTo: imagePicture.trailingAnchor, constant: 2.0).isActive = true
        
        labelDescription.numberOfLines = 15
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        labelDescription.topAnchor.constraint(equalTo: imagePicture.bottomAnchor, constant: 0.0).isActive = true
        labelDescription.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
    }
}

// MARK: - Methods used by the view controller to manipulate the interface
extension BasketProductView
{
    func update(viewModel: BasketProductViewModel?)
    {
        guard let model = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
            if let topSpeed = model.topSpeed
            {
                self.labelTopSpeed.text = String("Top speed: \(topSpeed)")
            }
            
            if let price = model.price
            {
                self.labelPrice.text = String("Price: \(price)")
            }
            
            self.labelDescription.text = model.description
        }
        
        if let imageURL = model.imageURL
        {
            if let url = URL(string: imageURL)
            {
                DispatchQueue.global(qos: .background).async {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        
                        // Update interface in the main thread
                        DispatchQueue.main.async {
                            self.imagePicture.image = image
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
    }
}

// MARK: - Factories
extension BasketProductView
{
    class func create(owner: Any) -> BasketProductView?
    {
        let bundle = Bundle.main
        let nibName = String(describing: BasketProductView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: owner, options: nil).first as? BasketProductView
    }
}
