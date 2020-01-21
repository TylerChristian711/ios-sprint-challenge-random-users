//
//  User.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

struct User:  Codable, Hashable {
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case phone
        case picture
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let email = try container.decode(String.self, forKey: .email)
        let phone = try container.decode(String.self, forKey: .phone)
        let name = try container.decode(Name.self, forKey: .name)
        let picture = try container.decode(Picture.self, forKey: .picture)
        
        
        
        self.email = email
        self.phone = phone
        self.name = name
        self.picture = picture
        
        
        
        
    }
    
    
}
struct Name:  Codable, Hashable {
    let title: String
    let first: String
    let last: String
    
    enum NameKeys: String, CodingKey {
        case title
        case first
        case last
    }
}
struct Picture: Codable, Hashable {
    let large: String
    let medium: String
    let thumbnail: String
    
    enum PictureKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
}
//struct UserInfo: Codable {
//    let seed: String
//    let results: Int
//    let page: Int
//    let version: String
//}


struct Results: Codable {
    let results: [User]
    
    init() {
        self.results = []
    }
    
    enum ResultsKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsKeys.self)
        var userContainer = try container.nestedUnkeyedContainer(forKey: .results)
        var placeholder = [User]()
        while !userContainer.isAtEnd {
            let user = try userContainer.decode(User.self)
            placeholder.append(user)
        }
        self.results = placeholder
    }
}
