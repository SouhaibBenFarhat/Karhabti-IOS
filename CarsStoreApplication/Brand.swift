//
//  Article.swift
//  TestLoginGoogle
//
//  Created by mac on 16/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class Brand {
    
    var id : String = ""
    var name : String = ""
    var cover : String?
    var logo : URL?
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        self.id = (articleDictionairy["id"] as? String)!
        self.logo = NSURL(string: articleDictionairy["logo"] as! String) as? URL
        self.cover = (articleDictionairy["cover"] as? String)!
        self.name = (articleDictionairy["name"] as? String)!
    }
    
    
    init(name : String , logo : URL , cover : String ,id : String ){
        self.name = name
        self.logo = logo
        self.cover = cover
        self.id = id
        
        
    }
    
    
    static func downloadAllBrands () -> [Brand]
    {
        var Brands = [Brand]()
        
        let url = NSURL(string: URLS.GET_BRANDS)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let articleDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in articleDictionaies {
                let newBrand = Brand(articleDictionairy: articleDictionairy)
                Brands.append(newBrand)
                
            }
            
            
        }
        
        return Brands
    }
    
    
    
}

