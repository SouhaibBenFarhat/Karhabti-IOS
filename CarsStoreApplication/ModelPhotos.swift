//
//  Article.swift
//  TestLoginGoogle
//
//  Created by mac on 16/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ModelPhoto {
    
    var id : String = ""
    var url : URL?
    var model_id : String = ""

    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.url = NSURL(string: articleDictionairy["url"] as! String) as? URL
        self.model_id = (articleDictionairy["model_id"] as? String)!

        
    }
    
    
    init(id : String , url : URL , gamme : String ){
        
        self.id = id
        self.url = url
        self.model_id = gamme

        
    }
    
    
    
    static func downloadAllPhotos (idd : String) -> [ModelPhoto]
    {
        var photos = [ModelPhoto]()
        
        let url = NSURL(string:  URLS.DOWNLOAD_ALL_MODEL_PHOTO + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let photoDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in photoDictionaies {
                let newPhoto = ModelPhoto(articleDictionairy: articleDictionairy)
                photos.append(newPhoto)
                
            }
            
            
        }
        print(photos.count)
        return photos
    }
    
    
    
}

