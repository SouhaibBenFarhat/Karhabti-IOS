//
//  Favoris.swift
//  CarsStoreApplication
//
//  Created by mac on 19/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import Firebase

class Favoris{
    
 
    
    var id : String = ""
    var created_at : String = ""
    var id_gamme : String = ""
    var id_user : String = ""
  
    
    
    
    
    
    
    init() {
        
    }
    
    init(favorisDictionairy : [String : AnyObject]) {
        
        self.id = (favorisDictionairy["id"] as? String)!
        self.created_at = (favorisDictionairy["created_at"] as? String)!
        self.id_gamme = (favorisDictionairy["id_gamme"] as? String)!
        self.id_user = (favorisDictionairy["id_user"] as? String)!
        
        
        
    }
    
    
    init(id : String , created_at : String, id_gamme : String, id_user : String ){
        
        self.id = id
        self.created_at = created_at
        self.id_gamme = id_gamme
        self.id_user = id_user
        
    }
    
    static func addUserFavoris (idUser : String, idGamme : String) -> Bool
    {
        
        
        var state : Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: URLS.ADD_USER_FAVORIS)!)
        request.httpMethod = URLS.POST_METHOD
        let postString = "id_gamme=\(idGamme)&id_user=\(idUser)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                state = false
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            state = true
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return state
      
    }
    
    
    static func didFavorisExiste (idUser : String, idGamme : String) -> Bool
    {
        var favoris = [Favoris]()
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.DID_FAVORIS_EXIST + "id_gamme=\(idGamme)&id_user=\(idUser)")
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                for dictionary in json as! [[String: AnyObject]]{
                    let f = Favoris()
                    f.id = dictionary["id"] as! String
                    favoris.append(f)
                }
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        if favoris.count > 0{
            return true
        }
        else
        {
        return false
        }
        
        
        
    }
    
    
    
    
    static func deleteUserFavoris (idUser : String, idGamme : String) -> Bool
    {
        
        
        var state : Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: URLS.DELETE_USER_FAVORIS)!)
        request.httpMethod = URLS.POST_METHOD
        let postString = "user_id=\(idUser)&gamme_id=\(idGamme)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                state = false
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            state = true
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return state
        
    }


    
    
}
