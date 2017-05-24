//
//  ModelLogo.swift
//  CarsStoreApplication
//
//  Created by mac on 26/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class BrandLogo{
    
    
    var id : String = ""
    var name : String = ""
    var logo : String = ""
    
    

    
    
    init() {
        
        
    }
    
    static func downloadBrandLogo (brand_id : String) -> [BrandLogo]
    {
        
        
        
        var logos = [BrandLogo]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_BRAND_LOGO + brand_id)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                for dictionary in json as! [[String: AnyObject]]{
                    let bl = BrandLogo()
                    bl.id = dictionary["id"] as! String
                    bl.name = dictionary["name"] as! String
                    bl.logo = dictionary["logo"] as! String
           
                    
                    
                    
                    logos.append(bl)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return logos
        
        
        
        
    }

    
    
    
}
