//
//  Annonce.swift
//  CarsStoreApplication
//
//  Created by mac on 25/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD


class Annonce{
    
    var id : String = ""
    var type : String = ""
    var brand_id : String = ""
    var model :String = ""
    var annee : String = ""
    var transmissiom : String = ""
    var puissance_fiscal : String = ""
    var kilometrage = ""
    var couleur : String = ""
    var nombrePorte = ""
    var carburant : String = ""
    var date_mise_circulation : String = ""
    var prix : String = ""
    var num_tel : String = ""
    var etat : String = ""
    var category : String = ""
    var date_publication : String = ""
    var user_id : String = ""
    var autreDescription : String  = ""
    
    
    
    init() {
        
    
    }
    
    static func downloadAllAnnonces () -> [Annonce]
    {
        
        
        
        var annonces = [Annonce]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_ANNONCES)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                showMessage(title: "Oups !", msg: "Impossible d'atteindre le serveur ! ")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let a = Annonce()
                    a.id = dictionary["id"] as! String
                    a.type = dictionary["type"] as! String
                    a.brand_id = dictionary["brand_id"] as! String
                    a.model = dictionary["model"] as! String
                    a.annee = dictionary["annee"] as! String
                    a.transmissiom = dictionary["transmission"] as! String
                    a.puissance_fiscal = dictionary["puissance_fiscal"] as! String
                    a.kilometrage = dictionary["kilometrage"] as! String
                    a.couleur = dictionary["couleur"] as! String
                    a.nombrePorte = dictionary["nb_porte"] as! String
                    a.carburant = dictionary["carburant"] as! String
                    a.date_mise_circulation = dictionary["date_mise_circulation"] as! String
                    a.prix = dictionary["prix"] as! String
                    a.num_tel = dictionary["num_tel"] as! String
                    a.etat = dictionary["etat"] as! String
                    a.category = dictionary["category"] as! String
                    a.autreDescription = dictionary["autre_description"] as! String
                    a.user_id = dictionary["user_id"] as! String
                    a.date_publication = dictionary["date_publication"] as! String



                    annonces.append(a)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return annonces
 
        
    }
    
    
    
    
    
    static func downloadUserAnnonce (idUser : String ) -> [Annonce]
    {
        
        
        
        var annonces = [Annonce]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_ANNONCE_BY_USER + idUser)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                showMessage(title: "Oups", msg: "Serveur introuvable !")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let a = Annonce()
                    a.id = dictionary["id"] as! String
                    a.type = dictionary["type"] as! String
                    a.brand_id = dictionary["brand_id"] as! String
                    a.model = dictionary["model"] as! String
                    a.annee = dictionary["annee"] as! String
                    a.transmissiom = dictionary["transmission"] as! String
                    a.puissance_fiscal = dictionary["puissance_fiscal"] as! String
                    a.kilometrage = dictionary["kilometrage"] as! String
                    a.couleur = dictionary["couleur"] as! String
                    a.nombrePorte = dictionary["nb_porte"] as! String
                    a.carburant = dictionary["carburant"] as! String
                    a.date_mise_circulation = dictionary["date_mise_circulation"] as! String
                    a.prix = dictionary["prix"] as! String
                    a.num_tel = dictionary["num_tel"] as! String
                    a.etat = dictionary["etat"] as! String
                    a.category = dictionary["category"] as! String
                    a.autreDescription = dictionary["autre_description"] as! String
                    a.user_id = dictionary["user_id"] as! String
                    a.date_publication = dictionary["date_publication"] as! String
                    
                    
                    
                    annonces.append(a)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return annonces
        
        
    }
    
    
    
    
    static func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }

    
    
    
    static func insertUserAnnonce (annonce : Annonce)
    {
        
        
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: URLS.INSERT_ANNONCE)!)
        request.httpMethod = URLS.POST_METHOD
        
        
        
        let postString = "type=\(annonce.type)&brand_id=\(annonce.brand_id)&model=\(annonce.model)&annee=\(annonce.annee)&transmission=\(annonce.transmissiom)&puissance_fiscal=\(annonce.puissance_fiscal)&kilometrage=\(annonce.kilometrage)&couleur=\(annonce.couleur)&nb_porte=\(annonce.nombrePorte)&carburant=\(annonce.carburant)&date_mise_circulation=\(annonce.date_mise_circulation)&prix=\(annonce.prix)&num_tel=\(annonce.num_tel)&etat=\(annonce.etat)&category=\(annonce.category)&autre_description=\(Annonce.removeSpecialCharsFromString(text: annonce.autreDescription))&date_publication=\(annonce.date_publication)&user_id=\(annonce.user_id)"
        
        
        print(annonce.nombrePorte)
        
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error")
                KRProgressHUD.dismiss()
                Annonce.showMessage(title: "Oups", msg: "Serveur introuvable")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
              
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
    }

    
    
    static func getLastAnnonceId (userId : String) -> String
    {
        
        
        var id = ""
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_LAST_ANNONCE_ID + userId)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                KRProgressHUD.dismiss()
                showMessage(title: "Oups", msg: "Serveur Introuvable")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    id = dictionary["id"] as! String
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return id
        
        
    }

    static func deleteUserAnnonce (annonceId : String)
    {
        
        
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: URLS.DELETE_ANNONCE)!)
        request.httpMethod = URLS.POST_METHOD
        
        
        
        let postString = "annonce_id=\(annonceId)"
        
    
        
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental 
                Annonce.showMessage(title: "Oups", msg: "Serveur introuvable")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
    }
    
    
    
    static func findAnnonceByModel (model_name : String ) -> [Annonce]
    {
        
        
        
        var annonces = [Annonce]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.FIND_ANNONCE_BY_MODELE + model_name)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")

                return
                
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let a = Annonce()
                    a.id = dictionary["id"] as! String
                    a.type = dictionary["type"] as! String
                    a.brand_id = dictionary["brand_id"] as! String
                    a.model = dictionary["model"] as! String
                    a.annee = dictionary["annee"] as! String
                    a.transmissiom = dictionary["transmission"] as! String
                    a.puissance_fiscal = dictionary["puissance_fiscal"] as! String
                    a.kilometrage = dictionary["kilometrage"] as! String
                    a.couleur = dictionary["couleur"] as! String
                    a.nombrePorte = dictionary["nb_porte"] as! String
                    a.carburant = dictionary["carburant"] as! String
                    a.date_mise_circulation = dictionary["date_mise_circulation"] as! String
                    a.prix = dictionary["prix"] as! String
                    a.num_tel = dictionary["num_tel"] as! String
                    a.etat = dictionary["etat"] as! String
                    a.category = dictionary["category"] as! String
                    a.autreDescription = dictionary["autre_description"] as! String
                    a.user_id = dictionary["user_id"] as! String
                    a.date_publication = dictionary["date_publication"] as! String
                    
                    
                    
                    annonces.append(a)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return annonces
        
        
    }

    static func showMessage(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}
extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}


