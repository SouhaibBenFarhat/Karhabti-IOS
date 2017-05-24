//
//  Article.swift
//  TestLoginGoogle
//
//  Created by mac on 16/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD

class Gamme {
    
    var id : String = ""
    var gamme : String = ""
    var description : String = ""
    var prix : String = ""
    var model_id : String = ""
    var brand_id : String = ""
    var caracteristique_id : String = ""
    var motorisation_id : String = ""
    var raffinement_id : String = ""
    var picture_url : URL?
    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.gamme = (articleDictionairy["gamme"] as? String)!
        self.description = ((articleDictionairy["description"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines))!
        self.prix = (articleDictionairy["prix"] as? String)!
        self.model_id = (articleDictionairy["model_id"] as? String)!
        self.brand_id = (articleDictionairy["brand_id"] as? String)!
        self.caracteristique_id = (articleDictionairy["caracteristique_id"] as? String)!
        self.motorisation_id = (articleDictionairy["motorisation_id"] as? String)!
        self.raffinement_id = (articleDictionairy["raffinement_id"] as? String)!
        self.picture_url = NSURL(string: (articleDictionairy["picture_url"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)) as? URL
        
    }
    
    
    init(id : String , picture_url : URL , gamme : String ,description : String, prix : String, model_id : String, brand_id : String ,caracteristique_id : String, motorisation_id : String, raffinement_id : String ){
        
        self.id = id
        self.picture_url = picture_url
        self.gamme = gamme
        self.description = description.trimmingCharacters(in: .whitespacesAndNewlines)
        self.prix = prix
        self.model_id = model_id
        self.brand_id = brand_id
        self.caracteristique_id = caracteristique_id
        self.motorisation_id = motorisation_id
        self.raffinement_id = raffinement_id

    }
    
    
    
    static func downloadAllGammes (idd : String) -> [Gamme]
    {
        var Gammes = [Gamme]()
        
        let url = NSURL(string: URLS.GET_ALL_GAMME + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)

        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let GammeDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in GammeDictionaies {
                let newGamme = Gamme(articleDictionairy: articleDictionairy)
                Gammes.append(newGamme)
                
            }
            
            
        }
        
        return Gammes
    }
    
    
    
    static func getGammeById (gammeId : String) -> Gamme
    {
        var Gammes = [Gamme]()
        
        let url = NSURL(string: URLS.GET_GAMME_BY_ID + gammeId)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)
        
        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let GammeDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in GammeDictionaies {
                let newGamme = Gamme(articleDictionairy: articleDictionairy)
                Gammes.append(newGamme)
                
            }
            
            
        }
        
        return Gammes[0]
    }
    
    
    static func downloadGammeFavoris (idUser : String) -> [Gamme]
    {
        
        
        
        var gammes = [Gamme]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_GAMME_FAVORIS + idUser)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                Annonce.showMessage(title: "Oups", msg: "Serveur introuvable")
                return
            }
            do {
             
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let g = Gamme()
                    g.id = dictionary["id"] as! String
                    g.gamme = dictionary["gamme"] as! String
                    g.description = dictionary["description"] as! String
                    g.prix = dictionary["prix"] as! String
                    g.model_id = dictionary["model_id"] as! String
                    g.brand_id = dictionary["brand_id"] as! String
                    g.caracteristique_id = dictionary["caracteristique_id"] as! String
                    g.motorisation_id = dictionary["motorisation_id"] as! String
                    g.raffinement_id = dictionary["raffinement_id"] as! String
                    g.picture_url = NSURL(string: (dictionary["picture_url"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)) as URL?

                    gammes.append(g)
                }
         
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        print("here")
        print(gammes.count)
        return gammes
        
        
        
        
    }

    
    
    
}

