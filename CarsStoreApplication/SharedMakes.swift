//
//  SharedMakes.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import KRProgressHUD


class SharedMakes{
    
    
    var id : String = ""
    var name : String = ""
    var logo : String = ""
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.name = (articleDictionairy["name"] as? String)!
        self.logo = (articleDictionairy["logo"] as? String)!
        
        
        
    }
    
    
    init( id : String, name : String, logo : String ){
        
        self.id = id
        self.name = name
        self.logo = logo
        
        
    }
    
    
    static func downloadSharedMakes (year : String) -> [SharedMakes]
    {
        
        
        
        var sharedMakes = [SharedMakes]()
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_SHARED_MAKES + year)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                Annonce.showMessage(title: "Oups !", msg: "Impossible de trouver le servuer !")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let sm = SharedMakes()
                    sm.id = dictionary["id"] as! String
                    sm.name = dictionary["name"] as! String
                    sm.logo = dictionary["logo"] as! String

                    sharedMakes.append(sm)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return sharedMakes
        
        
        
        
    }
    
    
    

}
