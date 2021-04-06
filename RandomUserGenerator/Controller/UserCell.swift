//
//  UserCell.swift
//  RandomUserGenerator
//
//  Created by Blashko Maksim on 04.04.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    private let apiManager = ApiManager.shared
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    func setupCell(user: User) {

        if user.picture.large != "" {
            apiManager.getUserImage(url: user.picture.large) { (image) in
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }
        
        self.nameLabel.text = user.name.title + " " + user.name.first  + " " + user.name.last
        self.ageLabel.text = String(user.dob.age) + " years old"
        self.locationLabel.text = user.location.city + " " + user.location.state
    }
    
}
