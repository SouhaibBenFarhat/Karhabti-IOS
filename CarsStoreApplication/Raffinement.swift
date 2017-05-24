//
//  Raffinement.swift
//  CarsStoreApplication
//
//  Created by mac on 19/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class Raffinement{
    
    
    var id : String = ""
    var connectivite : String = ""
    var nombre_airbag : String = ""
    var jante : String = ""
    var climatisation : String = ""

    
    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.connectivite = (articleDictionairy["connectivite"] as? String)!
        self.nombre_airbag = (articleDictionairy["nombre_airbag"] as? String)!
        self.jante = (articleDictionairy["jante"] as? String)!
        self.climatisation = (articleDictionairy["climatisation"] as? String)!

        
        
    }
    
    
    init(id : String , carrosserie : String, nombre_place : String, nombre_porte : String, longueur : String, largeur : String ,hauteur : String, volume_coffre : String ){
        
        self.id = id
        self.connectivite = carrosserie
        self.nombre_airbag = nombre_place
        self.jante = nombre_porte
        self.climatisation = longueur

        
        
    }
    
    
    
    static func downloadRaffinement (idd : String) -> [Raffinement]
    {
        var raffinements = [Raffinement]()
        
        let url = NSURL(string: URLS.DOWNLOAD_RAFFINEMET + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)
        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let raffinementDictionairy = jsonDictionary["item"] as! [[String : AnyObject]]
            for r in raffinementDictionairy {
                let raffinement = Raffinement(articleDictionairy: r)
                raffinements.append(raffinement)
                
            }
            
            
        }
        print(raffinements.count)
        return raffinements
    }
    

    
    
}
