//
//  NetworkHelper.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

class NetworkHelper{
    
    func makeGetRequest(urlString : String){
        
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return  }
        let task = session.dataTask(with: url) { (data, response, error) in
            
        }
        task.resume()
        
    }
}

