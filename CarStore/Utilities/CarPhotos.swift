//
//  CarPhotos.swift
//  CarStore
//
//  Created by Kristiyan Butev on 1.10.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

struct CarPhotos
{
    static func getCarImageURL(forManufacturer manufaturer: String) -> String?
    {
        switch manufaturer
        {
        case "Acura":
            return "https://www.carmax.com/~/media/images/carmax/com/Articles/acura-tl-reasons-to-buy/166604-rtb-acuratl-651x366.jpg"
        case "Audi":
            return "https://imgd.aeplcdn.com/1056x594/cw/ec/26916/Audi-Q3-Right-Front-Three-Quarter-92291.jpg?v=201711021421&q=80"
        case "Bentley":
            return "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/media/assets/submodel/8322.jpg"
        case "BMW":
            return "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/media/assets/submodel/8198.jpg"
        case "Buick":
            return "https://st.motortrend.ca/uploads/sites/10/2017/11/2017-buick-verano-leather-1sl-sedan-angular-front.png"
        case "Cadillac":
            return "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/media/assets/submodel/8327.jpg"
        case "Chevrolet":
            return "https://stimg.cardekho.com/car-images/carexteriorimages/630x420/Chevrolet/Chevrolet-Beat/front-left-side-047.jpg"
        default:
            return nil
        }
    }
}
