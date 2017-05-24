//
//  SharedModel.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import KRProgressHUD


class SharedModel{
    
    
    var model_id : String = ""
    var name : String = ""
    var makes_id : String = ""
    var make_name : String = ""
    var model_year : String = ""
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.model_id = (articleDictionairy["model_id"] as? String)!
        self.name = (articleDictionairy["name"] as? String)!
        self.makes_id = (articleDictionairy["makes_id"] as? String)!
        self.make_name = (articleDictionairy["make_name"] as? String)!
        self.model_year = (articleDictionairy["model_year"] as? String)!

        
        
        
    }
    
    
    init( model_id : String, name : String, makes_id : String, make_name : String, model_year : String ){
        
        self.model_id = model_id
        self.name = name
        self.makes_id = makes_id
        self.make_name = make_name
        self.model_year = model_year
        
        
    }
    
    
    static func downloadSharedModels (make_year : String, make_id : String ) -> [SharedModel]
    {
        
        
        
        var sharedModels = [SharedModel]()
        let semaphore = DispatchSemaphore(value: 0)
    let url = NSURL(string: URLS.GET_SHARED_MODELS + "make_year=\(make_year)&make_id=\(make_id)")
        
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                 Annonce.showMessage(title: "Oups !", msg: "Impossible de trouver le serveur !")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    
                    let sm = SharedModel()
                    
                    sm.model_id = dictionary["model_id"] as! String
                    sm.name = dictionary["name"] as! String
                    sm.makes_id = dictionary["makes_id"] as! String
                    sm.make_name = dictionary["make_name"] as! String
                    sm.model_year = dictionary["model_year"] as! String
                    
                    sharedModels.append(sm)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return sharedModels
        
        
        
        
    }
    
    
    
    
    
    
}
