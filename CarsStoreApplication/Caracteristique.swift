//
//  Caracteristique.swift
//  TestLoginGoogle
//
//  Created by mac on 18/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//
//

import UIKit

class Caracteristique {
    
    var id : String = ""
    var carrosserie : String = ""
    var nombre_place : String = ""
    var nombre_porte : String = ""
    var longueur : String = ""
    var largeur : String = ""
    var hauteur : String = ""
    var volume_coffre : String = ""

    
    
    
    
    init() {
        
    }
    
    init(articleDictionairy : [String : AnyObject]) {
        
        self.id = (articleDictionairy["id"] as? String)!
        self.carrosserie = (articleDictionairy["carrosserie"] as? String)!
        self.nombre_place = (articleDictionairy["nombre_place"] as? String)!
        self.nombre_porte = (articleDictionairy["nombre_porte"] as? String)!
        self.longueur = (articleDictionairy["longueur"] as? String)!
        self.largeur = (articleDictionairy["largeur"] as? String)!
        self.hauteur = (articleDictionairy["hauteur"] as? String)!
        self.volume_coffre = (articleDictionairy["volume_coffre"] as? String)!

        
    }
    
    
    init(id : String , carrosserie : String, nombre_place : String, nombre_porte : String, longueur : String, largeur : String ,hauteur : String, volume_coffre : String ){
        
        self.id = id
        self.carrosserie = carrosserie
        self.nombre_place = nombre_place
        self.nombre_porte = nombre_porte
        self.longueur = longueur
        self.largeur = largeur
        self.hauteur = hauteur
        self.volume_coffre = volume_coffre

        
    }
    
    
    
    static func downloadAllCaracteristiques (idd : String) -> [Caracteristique]
    {
        var caracteristiques = [Caracteristique]()
        
        let url = NSURL(string: URLS.DOWNLOAD_CARACTERISTIQUE + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)
        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let CaracteristiqueDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in CaracteristiqueDictionaies {
                let newCaracteristique = Caracteristique(articleDictionairy: articleDictionairy)
                caracteristiques.append(newCaracteristique)
                
            }
            
            
        }
        print(caracteristiques.count)
        return caracteristiques
    }
    
    
    
}

