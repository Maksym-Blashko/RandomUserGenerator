//
//  ViewController.swift
//  RandomUserGenerator
//
//  Created by Blashko Maksim on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {

    private let apiManager = ApiManager.shared
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiManager.getUsers { [weak self] arrayUsers in
            guard let self = self else { return }            
            self.users = arrayUsers
        }
    }
}
