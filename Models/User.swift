//
//  User.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

struct User: Codable {
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
}

struct Name: Codable {
    let title: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case firstName
        case lastName
    }
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
}

struct UserInfo: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct UserResults: Codable {
    let results: [User]
    let info: UserInfo
}
