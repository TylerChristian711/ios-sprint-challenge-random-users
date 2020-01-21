//
//  UserAPI.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class UserAPI {
    
 let baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")!
  
    func fetchUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        
    }
    
}
