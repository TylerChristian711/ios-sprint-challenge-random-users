//
//  UserTableViewController.swift
//  Random Users
//
//  Created by Lambda_School_Loaner_218 on 1/17/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var userController = UserController()
    var url = "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000"
    let cache: Cache = Cache<User, Data>()
    let detailCache = Cache<User, Data>()
    var photoFetchQueue = OperationQueue()
    var operations = [User : Operation]()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        print("this need to be printed")
        userController.fetchResults { (error) in
            print("check to see if network is called")
            if let error = error {
                print("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
            
            
        }

    }
    
    private func loadImage(forCell cell: UserTableViewCell, forItemAt indexPath: IndexPath) {
        
        let userRefrence = userController.users.results[indexPath.row]
        
        if let data = cache.value(key: userRefrence) {
            cell.imageThumbnail.image = UIImage(data: data)
            return
        }
        
        let thumbnailFetchOp = FetchPhotoOperation(image: userRefrence.picture.thumbnail)
        let detialFetchOp = FetchPhotoOperation(image: userRefrence.picture.large)
        
        let cacheOperation = BlockOperation {
            if let data = thumbnailFetchOp.imageData, let detialData = detialFetchOp.imageData {
                self.cache.cache(value: data, key: userRefrence)
                self.detailCache.cache(value: detialData, key: userRefrence)
                
                
            }
        }
        
        let finishingOPeration = BlockOperation {
            defer { self.operations.removeValue(forKey: userRefrence) }
            if let currentINdexPath = self.tableView.indexPath(for: cell), currentINdexPath != indexPath {
                print("this cell was already loaded")
                return
            }
            
            if let data = thumbnailFetchOp.imageData {
                cell.imageThumbnail.image = UIImage(data: data)
            }
        }
        
        cacheOperation.addDependency(thumbnailFetchOp)
        cacheOperation.addDependency(detialFetchOp)
        finishingOPeration.addDependency(thumbnailFetchOp)
        
        photoFetchQueue.addOperation(thumbnailFetchOp)
        photoFetchQueue.addOperation(detialFetchOp)
        photoFetchQueue.addOperation(cacheOperation)
        OperationQueue.main.addOperation(finishingOPeration)
        
        self.operations[userRefrence] = thumbnailFetchOp
        
        
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userController.users.results.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell
        else { return UITableViewCell() }
        
        loadImage(forCell: cell, forItemAt: indexPath)
        cell.user = userController.users.results[indexPath.row]
        
       
        

        return cell
    }
    


    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detialVC = segue.destination as? UserDetialViewController {
            if segue.identifier == "PersonSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    detialVC.user = userController.users.results[indexPath.row]
                    if let data = detailCache.value(key: userController.users.results[indexPath.row]) {
                        detialVC.imgData = data
                    }
                }
            }
        }
    }
    

}
