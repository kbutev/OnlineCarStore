//
//  NetworkErrors.swift
//  CarStore
//
//  Created by Kristiyan Butev on 19.09.18.
//  Copyright © 2018 Kristiyan Butev. All rights reserved.
//

import Foundation

enum NetworkError : String {
    case URL_ERROR = "URL error"
    case HTTP_ERROR = "HTTP error"
    case NETWORK_REQUEST_FAILED = "Network request failed"
    case BAD_RESPONSE = "Bad/invalid response"
}
