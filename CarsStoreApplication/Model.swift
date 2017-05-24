//
//  Article.swift
//  TestLoginGoogle
//
//  Created by mac on 16/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class Model {
    
    var id : String = ""
    var name : String = ""
    var year : String = ""
    var picture_url : URL?
    var brand_id : String = ""
    var description : String = ""
    var price_from : String = ""
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        self.id = (articleDictionairy["id"] as? String)!
        self.picture_url = NSURL(string: articleDictionairy["picture_url"] as! String) as? URL
        self.name = (articleDictionairy["name"] as? String)!
        self.year = (articleDictionairy["year"] as? String)!
        self.brand_id = (articleDictionairy["brand_id"] as? String)!
        self.description = (articleDictionairy["description"] as? String)!
        self.price_from = (articleDictionairy["price_from"] as? String)!

    }
    
    
    init(id : String , picture_url : URL , name : String ,year : String, brand_id : String, description : String, price_from : String ){
        self.id = id
        self.picture_url = picture_url
        self.name = name
        self.year = year
        self.brand_id = brand_id
        self.description = description
        self.price_from = price_from
        
        
    }
    
    
    static func downloadAllModels (idd : String) -> [Model]
    {
        var Models = [Model]()
        
        let url = NSURL(string: URLS.GET_MODELS + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let articleDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in articleDictionaies {
                let newArticle = Model(articleDictionairy: articleDictionairy)
                Models.append(newArticle)
                
            }
            
            
        }
        
        return Models
    }
    
    
    
}

