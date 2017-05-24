//
//  MakeYears.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import KRProgressHUD


class MakeYears {
    
   
    var year : String = ""

    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
      
        self.year = (articleDictionairy["year"] as? String)!


        
    }
    
    
    init( year : String ){
        
        self.year = year


    }
    
    
    static func downloadYears () -> [MakeYears]
    {
        
        
        
        var makeYears = [MakeYears]()
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_MAKE_YEARS)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                    Annonce.showMessage(title: "Oups !", msg: "Impossible de trouver le servuer !")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let m = MakeYears()
                    m.year = dictionary["year"] as! String
 
                    
                    makeYears.append(m)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)

        return makeYears
        
        
        
        
    }
    

    
    
}
