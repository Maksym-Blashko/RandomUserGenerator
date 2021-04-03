//
//  NetworkManager.swift
//  RandomUserGenerator
//
//  Created by Blashko Maksim on 03.04.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func performRequest(url: String, success: @escaping (Data)->(), failure: @escaping (Error?)->()) {
        
        guard let url = URL(string: url) else { failure(nil); return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let error = error { failure(error); return }
            
            if let data = data {
                success(data)
            } else {
                failure(nil)
            }
            
        }.resume()
    }
}
