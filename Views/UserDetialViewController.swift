//
//  UserDetialViewController.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserDetialViewController: UIViewController {
    
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var largeUserImage: UIImageView!
    

    
    var user: User?
    var userController: UserController?
    var imgData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let user = user else { return }
        if let imgData = imgData {
            largeUserImage.image = UIImage(data: imgData)
        }
        titleLabel.text = user.name.title
        nameLabel.text =  user.name.first 
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        
    }
    
}
