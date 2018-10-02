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
            if let engine = model.engine
            {
                self.labelTopSpeed.text = String("Engine: \(engine)")
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
                            if let dummyImage = self.resizeImage(image: image, newWidth: 2)
                            {
                                if let backgroundColor = self.getPixelColor(image: dummyImage, pos: CGPoint(x: 0, y: 0))
                                {
                                    self.imagePicturePreview.backgroundColor = backgroundColor
                                }
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
        
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight), blendMode: .normal, alpha: 1.0)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func getPixelColor(image: UIImage, pos: CGPoint) -> UIColor?
    {
        guard let imageData = image.cgImage?.dataProvider?.data else {
            return nil
        }
        
        guard let pixelData = CGDataProvider(data: imageData)?.data else {
            return nil
        }
        
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(image.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func blendColors(c1: UIColor, c2: UIColor, alpha: Double) -> UIColor
    {
        var a = CGFloat(alpha)
        
        a = min(1.0, max(0.0, a))
        
        let beta = 1.0 - a
        
        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0
        
        c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 * beta + r2 * a
        let g = g1 * beta + g2 * a
        let b = b1 * beta + b2 * a
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func averageColor(image: UIImage) -> UIColor?
    {
        let rawImageRef : CGImage = image.cgImage!
        
        guard let dataProvider = rawImageRef.dataProvider else {
            return nil
        }
        
        guard let data = dataProvider.data else {
            return nil
        }
        
        let rawPixelData = CFDataGetBytePtr(data);
        
        let imageHeight = rawImageRef.height
        let imageWidth  = rawImageRef.width
        let bytesPerRow = rawImageRef.bytesPerRow
        let stride = rawImageRef.bitsPerPixel / 6
        
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        
        for row in 0...imageHeight {
            var rowPtr = rawPixelData! + (bytesPerRow * row)
            for _ in 0...imageWidth {
                red    += CGFloat(rowPtr[0])
                green  += CGFloat(rowPtr[1])
                blue   += CGFloat(rowPtr[2])
                rowPtr += Int(stride)
            }
        }
        
        let f : CGFloat = 1.0 / (255.0 * CGFloat(imageWidth) * CGFloat(imageHeight))
        
        return UIColor(red: f * red, green: f * green, blue: f * blue , alpha: 1.0)
    }
    
    func mostCommonColor(image: UIImage) -> UIColor?
    {
        let rawImageRef : CGImage = image.cgImage!
        guard let dataProvider = rawImageRef.dataProvider else {
            return nil
        }
        guard let data = dataProvider.data else {
            return nil
        }
        
        let rawPixelData = CFDataGetBytePtr(data);
        
        let imageHeight = rawImageRef.height
        let imageWidth  = rawImageRef.width
        let bytesPerRow = rawImageRef.bytesPerRow
        let stride = rawImageRef.bitsPerPixel / 6
        
        var colors : [String : Int] = [:]
        
        for row in 0...imageHeight {
            var rowPtr = rawPixelData! + (bytesPerRow * row)
            for _ in 0...imageWidth {
                let red = Int(rowPtr[0])
                let green = Int(rowPtr[1])
                let blue = Int(rowPtr[2])
                let stringFromColor = String(format: "%0.3d%0.3d%0.3d", red, green, blue)
                
                if let entry = colors[stringFromColor]
                {
                    colors[stringFromColor] = entry + 1
                }
                else
                {
                    colors[stringFromColor] = 1
                }
                
                rowPtr += Int(stride)
            }
        }
        
        let blackColorAsString = "000000000"
        var mostCommonColor = blackColorAsString
        var mostCommonColorCount = 0
        
        for entry in colors
        {
            if entry.value > mostCommonColorCount
            {
                mostCommonColor = entry.key
                mostCommonColorCount = entry.value
            }
        }
        
        let red = Int(mostCommonColor[String.Index(encodedOffset: 0)...String.Index(encodedOffset: 2)])
        let green = Int(mostCommonColor[String.Index(encodedOffset: 3)...String.Index(encodedOffset: 5)])
        let blue = Int(mostCommonColor[String.Index(encodedOffset: 6)...String.Index(encodedOffset: 8)])
        
        if red != nil && green != nil && blue != nil
        {
            return UIColor(red: CGFloat(red!), green: CGFloat(green!), blue: CGFloat(blue!), alpha: 1)
        }
        
        return nil
    }
}
