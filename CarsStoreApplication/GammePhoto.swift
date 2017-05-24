//
//  Article.swift
//  TestLoginGoogle
//
//  Created by mac on 16/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class GammePhoto {
    
    var id : String = ""
    var url : URL?
    var gamme : String = ""

    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {

        self.url = NSURL(string: (articleDictionairy["url"] as! String).trimmingCharacters(in: .whitespaces)) as? URL

        
    }
    
    
    init(id : String , url : URL , gamme : String ){
        
        self.id = id
        self.url = url
        self.gamme = gamme

        
    }
    
    
    
    static func downloadAllPhotos (idd : String) -> [GammePhoto]
    {
        var photos = [GammePhoto]()
        
        let url = NSURL(string: URLS.DOWNLOAD_ALL_GAMME_PHOTO + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let photoDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in photoDictionaies {
                let newPhoto = GammePhoto(articleDictionairy: articleDictionairy)
                photos.append(newPhoto)
                
            }
            
            
        }
        print(photos.count)
        return photos
    }
    
    
    
}

