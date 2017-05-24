//
//  Motorisation.swift
//  CarsStoreApplication
//
//  Created by mac on 19/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class Motorisation  {
    
    var id : String = ""
    var nombre_cylindre : String = ""
    var energie : String = ""
    var puissance_fiscal : String = ""
    var puissance_chdin : String = ""
    var couple : String = ""
    var cylindree : String = ""
    var consommation_urbaine : String = ""
    var consommation_mixte : String = ""
    var zero_cent : String = ""
    var vitesse_max : String = ""

    
    
    
    
    
    init() {
        
    }
    
    init(motorisationDictionairy : [String : AnyObject]) {
        
        self.id = (motorisationDictionairy["id"] as? String)!
        self.nombre_cylindre = (motorisationDictionairy["nombre_cylindre"] as? String)!
        self.energie = (motorisationDictionairy["energie"] as? String)!
        self.puissance_fiscal = (motorisationDictionairy["puissance_fiscal"] as? String)!
        self.puissance_chdin = (motorisationDictionairy["puissance_chdin"] as? String)!
        self.couple = (motorisationDictionairy["couple"] as? String)!
        self.cylindree = (motorisationDictionairy["cylindree"] as? String)!
        self.consommation_urbaine = (motorisationDictionairy["consommation_urbaine"] as? String)!
        self.consommation_mixte = (motorisationDictionairy["consommation_mixte"] as? String)!
        self.zero_cent = (motorisationDictionairy["zero_cent"] as? String)!
        self.vitesse_max = (motorisationDictionairy["vitesse_max"] as? String)!

        
        
    }
    
    
    init(id : String , nombre_cylindre : String, energie : String, puissance_fiscal : String, puissance_chdin : String, couple : String ,cylindree : String, consommation_urbaine : String,
         consommation_mixte : String, zero_cent : String, vitesse_max : String){
        
        self.id = id
        self.nombre_cylindre = nombre_cylindre
        self.energie = energie
        self.puissance_fiscal = puissance_fiscal
        self.puissance_chdin = puissance_chdin
        self.couple = couple
        self.cylindree = cylindree
        self.consommation_urbaine = consommation_urbaine
        self.consommation_mixte = consommation_mixte
        self.zero_cent = zero_cent
        self.vitesse_max = vitesse_max

        
        
    }
    
    
    
    static func downloadAllMotorisation (idd : String) -> [Motorisation]
    {
        var caracteristiques = [Motorisation]()
        
        let url = NSURL(string: URLS.DOWNLOAD_MOTORISATION + idd)
        
        
        
        let jsonFilee = NSData(contentsOf: url as! URL)
        if let jsonDictionary = GetFeaturedCars.parsJSONFromData(jsonData: jsonFilee) {
            let CaracteristiqueDictionaies = jsonDictionary["item"] as! [[String : AnyObject]]
            
            for articleDictionairy in CaracteristiqueDictionaies {
                let newCaracteristique = Motorisation(motorisationDictionairy: articleDictionairy)
                caracteristiques.append(newCaracteristique)
                
            }
            
            
        }
        print(caracteristiques.count)
        print("here")
        return caracteristiques
    }
    
    
    
}
