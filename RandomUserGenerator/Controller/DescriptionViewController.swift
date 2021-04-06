//
//  DescriptionViewController.swift
//  RandomUserGenerator
//
//  Created by Blashko Maksim on 06.04.2021.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    private let apiManager = ApiManager.shared
    
    var phoneNumber: String = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        if let phoneCallURL:URL = URL(string: "tel:\(phoneNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    let alertController = UIAlertController(title: "", message: "Are you sure you want to call \n\(self.phoneNumber)?", preferredStyle: .alert)
                    let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        application.openURL(phoneCallURL)
                    })
                    let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in

                    })
                    alertController.addAction(yesPressed)
                    alertController.addAction(noPressed)
                    present(alertController, animated: true, completion: nil)
                }
            }
    }
    
    func setupView() {
        
        guard let user = user else { return }
        
        if user.picture.large != "" {
            apiManager.getUserImage(url: user.picture.large) { (image) in
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }
        
        phoneNumber = user.phone
        callButton.setTitle("Phone: " + user.phone, for: .normal)
        
        nameLabel.text = "Name: " + user.name.title + " " + user.name.first  + " " + user.name.last + "\n gender: " + user.gender.rawValue
        dobLabel.text = "Date of birth: " + getDateFormat(input: user.dob.date) + "\n age: " + String(user.dob.age)
        emailLabel.text = "Mail: " + user.email
        descriptionLabel.text = "More about me:\n I am from " + user.location.city + " in " + user.location.country + ".\n I have been registered here for " + String(user.registered.age) + " years"
        
    }
    
    func getDateFormat(input: String) -> String {

        var subString = input
        
        if subString.count > 9 {
            let range = subString.index(subString.endIndex, offsetBy: (10-subString.count))..<subString.endIndex
            subString.removeSubrange(range)
            return subString
        } else {
            return ""
        }
    }
}
