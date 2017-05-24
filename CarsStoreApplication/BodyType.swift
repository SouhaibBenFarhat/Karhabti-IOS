//
//  BodyType.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class BodyType {
    
    
    
    
    var id : String = ""
    var body : String = ""
    var logo : String = ""
    
    
    
    
    
    
    
    
    init() {
        
    }
    
    init(favorisDictionairy : [String : AnyObject]) {
        
        self.id = (favorisDictionairy["id"] as? String)!
        self.body = (favorisDictionairy["created_at"] as? String)!
        self.logo = (favorisDictionairy["id_gamme"] as? String)!


        
        
        
    }
    
    
    init(id : String , body : String, logo : String ){
        
        self.id = id
        self.body = body
        self.logo = logo

        
    }
    
    
    

   static func downloadBodyTypes() -> [BodyType] {
       
        
        var bodyTypes = [BodyType]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_BODY_TYPE )
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let b = BodyType()
                    b.id = dictionary["id"] as! String
                    b.body = dictionary["body"] as! String
                    b.logo = dictionary["logo"] as! String
                    
                    bodyTypes.append(b)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)

        return bodyTypes
        
        

        
        
        
    }
    
    

    
}
