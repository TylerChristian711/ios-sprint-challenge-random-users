//
//  UserController.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badResponse
    case badData
    case noDecode
}

class UserController {
    
    var users = Results()
    let baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")!
    
    func fetchAllUsers<T:Codable>(for target:String, completion: @escaping (T?, Error?) -> ()) {
        let url = URL(string: target)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(nil,error)
                return
            }
            
            if let error = error {
                print("Error could not fetch users errorCode: \(error.localizedDescription)")
                completion(nil,error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let users = try decoder.decode(T.self, from: data)
                print("Data decoded!")
                completion(users, nil)
            } catch {
                print("error decoding data: \(error)")
                completion(nil,error)
                return
            }
            
            
        }.resume()
    }
    
    func fetchResults(completion: @escaping (Error?) -> ()) {
        fetchAllUsers(for: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000") { (results:Results?, error) in
            guard let results = results else {
                print("network not called")
                completion(error)
                return
            }
             self.users = results
             completion(nil)
        }
    }
    
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let thumbnailURL = URL(string: urlString) else {
            completion(.failure(.badData))
            return
        }
        var request = URLRequest(url: thumbnailURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("response error: \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("bad data")
                completion(.failure(.badData))
                return
            }
            
            guard let userThumbnailImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(.success(userThumbnailImage))
            }
            
            
        }
    }

}
