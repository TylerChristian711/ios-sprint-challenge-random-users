//
//  UrlSecure.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/20/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

extension URL {
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
