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
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        loadUsers()
        
    }
    
    func loadUsers() {
        apiManager.getUsers { [weak self] arrayUsers in
            guard let self = self else { return }
            
            self.users += arrayUsers
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDescription" {
            let descriptionVC = segue.destination as? DescriptionViewController
            guard let indexPath = sender as? IndexPath else { return }
            descriptionVC?.userDesc = [users[indexPath.row]]
        }
        
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell_id", for: indexPath) as! UserCell
        cell.setupCell(user: users[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == users.count - 1 {
            loadUsers()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDescription", sender: indexPath)
    }

}
