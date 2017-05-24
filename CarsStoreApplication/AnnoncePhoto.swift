//
//  AnnoncePhoto.swift
//  CarsStoreApplication
//
//  Created by mac on 26/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation
import KRProgressHUD
class AnnoncePhoto {
    
    
    var id : String = ""
    var file_name : String = ""
    var annonce_id : String = ""
    
    init() {
        
    }

    static func insertPhotoAnnonce (annoncePhoto : AnnoncePhoto) -> Bool
    {
        
       
        
        var state : Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: URLS.INSERT_ANNONCE_PHOTO)!)
        request.httpMethod = URLS.POST_METHOD
        
        
        
        let postString = "file_name=\(annoncePhoto.file_name)&annonce_id=\(annoncePhoto.annonce_id)"
    
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
             state = false
               
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                KRProgressHUD.dismiss()
                Annonce.showMessage(title: "Oups", msg: "Serveur introuvable !")
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            state = true
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return state
        
     
    }
    
    static func getAnnonceThumbNail (annonceId : String) -> String
    {
        
        
        var thumbnailImage : String? = ""
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_ANNONCE_THUMBNAIL + annonceId)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    thumbnailImage = dictionary["thumbnail_image"] as? String
                    
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        if  thumbnailImage != nil{
            return thumbnailImage!
        }else{
            return ""
        }
        
        
    }

    
    
    static func downloadAnnoncesPhotos (annonce_id : String) -> [AnnoncePhoto]
    {
        
        
        
        var annoncePhotos = [AnnoncePhoto]()
        
        let semaphore = DispatchSemaphore(value: 0)
        let url = NSURL(string: URLS.GET_ANNONCE_PHOTO + annonce_id)
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error)-> Void in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]]{
                    let a = AnnoncePhoto()
                    a.id = dictionary["id"] as! String
                    a.file_name = dictionary["file_name"] as! String
                    a.annonce_id = dictionary["annonce_id"] as! String

                    
                    
                    
                    annoncePhotos.append(a)
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            semaphore.signal()
            
            }.resume()
        
        
        _ = semaphore.wait(timeout: .distantFuture)
        return annoncePhotos
        
        
    }
    
    
}
