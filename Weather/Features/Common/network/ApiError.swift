//
//  ApiError.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation


enum APIError: Error{
    case badURL, requestFailed, jsonConversionFailure, invalidData, responseUnsuccessful
}
