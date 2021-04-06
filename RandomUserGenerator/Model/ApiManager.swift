//
//  ApiManager.swift
//  RandomUserGenerator
//
//  Created by Blashko Maksim on 03.04.2021.
//

import UIKit

class ApiManager {
    
    static let shared = ApiManager()
    private let networkManager = NetworkManager.shared
    private init() { }
    
    private let endpoint = "https://randomuser.me/api/"
    private var page: Int = 1
    
    func getUsers(complition: @escaping ([User])->(Void)) {
    
        let url = endpoint + "?" + "results=20" + "&" + "page=" + String(self.page)
        
        networkManager.performRequest(url: url) { (data) in
            
            do {
                let decodeData = try JSONDecoder().decode(UserResponse.self, from: data)
                self.page += 1
                complition(decodeData.results)
            } catch {
                print(error.localizedDescription)
            }
            
        } failure: { (error) in
            print(error?.localizedDescription as Any)
        }        
    }
    
    func getUserImage(url: String, complition: @escaping (UIImage)->(Void)) {
        
        networkManager.performRequest(url: url) { (data) in

            guard let image = UIImage(data: data) else { return }
            complition(image)
            
        } failure: { (error) in
            print(error?.localizedDescription as Any)
        }
    }
}
