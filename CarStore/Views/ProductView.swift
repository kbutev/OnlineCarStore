//
//  ProductView.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import UIKit

class ProductView : UIView
{
    @IBOutlet private weak var imagePicture: UIImageView!
    @IBOutlet private weak var imagePicturePreview: UIImageView!
    @IBOutlet private weak var labelTopSpeed: UILabel!
    @IBOutlet private weak var labelPrice: UILabel!
    @IBOutlet private weak var scrollViewDescription: UIScrollView!
    @IBOutlet private weak var labelDescription: UILabel!
    
    override func didMoveToSuperview()
    {
        setup()
    }
    
    func setup()
    {
        let layoutGuide = safeAreaLayoutGuide
        
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.widthAnchor.constraint(equalToConstant: 196).isActive = true
        labelPrice.heightAnchor.constraint(equalToConstant: 32).isActive = true
        labelPrice.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0.0).isActive = true
        labelPrice.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10.0).isActive = true
        labelPrice.textAlignment = .left
        
        labelTopSpeed.translatesAutoresizingMaskIntoConstraints = false
        labelTopSpeed.widthAnchor.constraint(equalToConstant: 196).isActive = true
        labelTopSpeed.heightAnchor.constraint(equalToConstant: 32).isActive = true
        labelTopSpeed.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0.0).isActive = true
        labelTopSpeed.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10.0).isActive = true
        labelTopSpeed.textAlignment = .right
        
        imagePicture.translatesAutoresizingMaskIntoConstraints = false
        imagePicture.widthAnchor.constraint(equalToConstant: 256).isActive = true
        imagePicture.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imagePicture.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 0.0).isActive = true
        imagePicture.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0.0).isActive = true
        
        let gesturePicture = UITapGestureRecognizer(target: self, action: #selector(actionTapImage))
        gesturePicture.numberOfTapsRequired = 1
        gesturePicture.numberOfTouchesRequired = 1
        imagePicture.addGestureRecognizer(gesturePicture)
        imagePicture.isUserInteractionEnabled = true
        
        scrollViewDescription.translatesAutoresizingMaskIntoConstraints = false
        scrollViewDescription.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        scrollViewDescription.topAnchor.constraint(equalTo: imagePicture.bottomAnchor, constant: 5.0).isActive = true
        scrollViewDescription.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -15.0).isActive = true
        scrollViewDescription.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
        
        labelDescription.numberOfLines = 100
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.topAnchor.constraint(equalTo: scrollViewDescription.topAnchor, constant: 0.0).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: scrollViewDescription.bottomAnchor, constant: 0.0).isActive = true
        labelDescription.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        imagePicturePreview.translatesAutoresizingMaskIntoConstraints = false
        imagePicturePreview.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0.0).isActive = true
        imagePicturePreview.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0.0).isActive = true
        imagePicturePreview.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0.0).isActive = true
        imagePicturePreview.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0.0).isActive = true
        
        let gesturePicturePreview = UITapGestureRecognizer(target: self, action: #selector(actionTapPreviewImage))
        gesturePicturePreview.numberOfTapsRequired = 1
        gesturePicturePreview.numberOfTouchesRequired = 1
        imagePicturePreview.addGestureRecognizer(gesturePicturePreview)
        imagePicturePreview.isUserInteractionEnabled = true
    }
}

// MARK: - Methods used by the view controller to manipulate the interface
extension ProductView
{
    func update(viewModel: ProductViewModel?)
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
                        
                        guard let pngImage = UIImage(data: data) else
                        {
                            return
                        }
                        
                        guard let image = self.convertToJPG(image: pngImage) else
                        {
                            return
                        }
                        
                        // Update interface in the main thread
                        DispatchQueue.main.async {
                            self.imagePicture.image = image
                            self.imagePicturePreview.image = image
                            
                            // We are going to fill the background if @imagePicturePreview with
                            // pattern color taken from @image
                            if let dummyImage = self.resizeImage(image: image, newWidth: 1)
                            {
                                let colorWithPattern = UIColor(patternImage: dummyImage)
                                self.imagePicturePreview.backgroundColor = colorWithPattern
                            }
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

// MARK: - Actions
extension ProductView
{
    @objc func actionTapImage()
    {
        imagePicturePreview.isHidden = false
    }
    
    @objc func actionTapPreviewImage()
    {
        imagePicturePreview.isHidden = true
    }
}

// MARK: - Factories
extension ProductView
{
    class func create(owner: Any) -> ProductView?
    {
        let bundle = Bundle.main
        let nibName = String(describing: ProductView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: owner, options: nil).first as? ProductView
    }
}

// MARK: - Utilities
extension ProductView
{
    func convertToJPG(image: UIImage) -> UIImage?
    {
        if let data = image.jpegData(compressionQuality: 1.0)
        {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage?
    {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
