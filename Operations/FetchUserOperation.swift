//
//  FetchUserOperation.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class FetchUserOperation: ConcurrentOperation {
    
    var user: [User]?
    let url = URL(string: " https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")!
    
    override func start() {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            defer {
                self.state = .isFinished
            }
            
            if let _ = error {
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(UserResults.self, from: data)
                self.user = results.results
            } catch {
                return
            }
        }.resume()
    }
    
}
