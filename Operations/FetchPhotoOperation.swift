//
//  FetchPhotoOperation.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    
    var image: String
    var imageData: Data?
    var task: URLSessionDataTask?
    
    init(image: String) {
        self.image = image
        super.init()
    }
    
    override func start() {
        state = .isExecuting

        guard let thumbnailURL = URL(string: image)?.usingHTTPS else { return }

        task = URLSession.shared.dataTask(with: thumbnailURL, completionHandler: { (data, _, error) in
            if let error = error {
                print("error line 29 PhotoOp")
                return
            }
            
            guard let data = data else { return }
            self.imageData = data
            self.state = .isFinished
        })
        
        task?.resume()
        
    }
    
    override func cancel() {
        task?.cancel()
    }
    
    
}
