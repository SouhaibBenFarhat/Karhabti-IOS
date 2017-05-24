//
//  Concessionnaire.swift
//  TestLoginGoogle
//
//  Created by mac on 18/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//
//

import UIKit

class Concessionnaire {
    
    var id : String = ""
    var name : String = ""
    var num_tel : String = ""
    var num_fax : String = ""
    var address : String = ""
    var description : String = ""
    var webSite : String = ""
    var logo : URL?

    
    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.name = (articleDictionairy["name"] as? String)!
        self.num_tel = (articleDictionairy["num_tel"] as? String)!
        self.num_fax = (articleDictionairy["num_fax"] as? String)!
        self.address = (articleDictionairy["address"] as? String)!
        self.description = (articleDictionairy["description"] as? String)!
        self.webSite = (articleDictionairy["web_site"] as? String)!
        self.logo = NSURL(string: articleDictionairy["logo"] as! String) as? URL
        


        
        
    }
    
    
    init(id : String , name : String, num_tel : String, num_fax : String, address : String, description : String ,logo : URL, webSite : String){
        
        self.id = id
        self.name = name
        self.num_tel = num_tel
        self.num_fax = num_fax
        self.address = address
        self.description = description
        self.logo = logo
        self.webSite = webSite

        
        
    }
    
    
    
    static func downloadAllConcessionnaires () -> [Concessionnaire]
    {
        var concessionnaires = [Concessionnaire]()
        
        let url = NSURL(string: URLS.GET_CONCESSIONNAIRES)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let ConcessionnaireDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in ConcessionnaireDictionaies {
                let newConcessionnaire = Concessionnaire(articleDictionairy: articleDictionairy)
                concessionnaires.append(newConcessionnaire)
                
            }
            
            
        }
               return concessionnaires
    }
    
    
    
}

