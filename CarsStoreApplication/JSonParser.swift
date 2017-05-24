//
//  getDataFromFirebase.swift
//  TestLoginGoogle
//
//  Created by mac on 14/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import Firebase


class GetFeaturedCars {
    
}



extension GetFeaturedCars
{
    static func parsJSONFromData (jsonData : NSData? ) -> [String : AnyObject]? {
              if let data  = jsonData {
            do{
                let jsonDictionry = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as!  [String : AnyObject]
                return jsonDictionry
                
            } catch let error as NSError {
                print("error processiong json data : \(error.localizedDescription)")
                
            }
            
            
        }
        
        return nil
    }
    
}
