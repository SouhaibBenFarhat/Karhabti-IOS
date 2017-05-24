//
//  News.swift
//  CarsStoreApplication
//
//  Created by mac on 22/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation



class News {
    
    var title : String = ""
    var description : String = ""
    var category : String = ""
    var thumbnailUrl : URL?
    var link : URL?
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        self.title = (articleDictionairy["title"] as? String)!
        self.thumbnailUrl = NSURL(string: articleDictionairy["url"] as! String) as? URL
        self.description = (articleDictionairy["description"] as? String)!
        self.category = (articleDictionairy["category"] as? String)!
        self.link = NSURL(string: articleDictionairy["link"] as! String) as? URL
    }
    
    
    init(title : String , link : URL , thumbnailUrl : URL , description : String ,category : String ){
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.description = description
        self.category = category
        self.link = link
        
        
    }
    
    
    static func downloadAllArticles () -> [News]
    {
        var articles = [News]()
        
        
        
        
        let url = NSURL(string: "http://elchebbi-ahmed.alwaysdata.net/xml_to_jsonMagasine.php")
        let jsonFilee = NSData(contentsOf: url as! URL)
        if let jsonDictionary = Parser.parsJSONFromData(jsonData: jsonFilee) {
            let articleDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in articleDictionaies {
                let newArticle = News(articleDictionairy: articleDictionairy)
                articles.append(newArticle)
                
            }
            
            
        }
        
        return articles
    }
}


class Parser {
    
}



extension Parser
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

