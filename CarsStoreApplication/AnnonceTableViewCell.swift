//
//  AnnonceTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 25/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import Firebase


class AnnonceTableViewCell: UITableViewCell {

    
    
    var brand = BrandLogo()

    
    

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var annonceBrand: UILabel!
    @IBOutlet weak var annonceModel: UILabel!
    @IBOutlet weak var annonceAnnee: UILabel!
    @IBOutlet weak var annonceEtat: UILabel!
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var datePublicationLabel: UILabel!
    @IBOutlet weak var annonceThumbnail: UIImageView!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var carburantLabel: UILabel!
    @IBOutlet weak var kilometrageLabel: UILabel!
    @IBOutlet weak var prixLabel: UILabel!
    
    
    
    
    // Public
    var newObject: Annonce! {
        didSet{
            updateUI()
        }
    }
    
    
    
    // Mark Private
    
 
    
    
    
    private func updateUI(){
        
        annonceThumbnail.layer.borderWidth = 0.5
        annonceThumbnail.layer.borderColor = UIColor.lightGray.cgColor
        annonceThumbnail.layer.cornerRadius = 5
        annonceThumbnail.layer.shadowOffset = CGSize(width: 0, height: 1)
        annonceThumbnail.layer.shadowOpacity = 0.3
        
      
        DispatchQueue.global(qos: .userInitiated).async {
            
            
            self.brand = BrandLogo.downloadBrandLogo(brand_id: self.newObject.brand_id)[0]

            
            DispatchQueue.main.async {

                self.brandLogo.sd_setImage(with: NSURL(string: self.brand.logo) as URL!)
                self.annonceBrand.text = self.brand.name

            }
        }
        
        
        
        

        DispatchQueue.global(qos: .background).async {
            var thImage = UIImage()
            let filename = AnnoncePhoto.getAnnonceThumbNail(annonceId: self.newObject.id)
            FIRStorage.storage().reference().child("annonces_photos").child(filename).downloadURL(completion: { (url,error) in
                if error != nil{
                    print(error ?? "")
                    return
                }
                
                
                URLSession.shared.dataTask(with: url!) { (data, response, error)-> Void in
                    if error != nil{
                        print(error ?? "")
                        return
                    }
                    
                    thImage = UIImage(data: data! as Data)!
                    DispatchQueue.main.async {

                        self.annonceThumbnail.image = thImage

                        
                    }
                    }.resume()
                
            })
            
        
        }
        
        
        
        
        
        
        
        
            
            

        
        
        
        
        
        
        
      
        
        
        
        
        

        
        
        

        datePublicationLabel.text! = newObject.date_publication
        annonceModel.text = newObject.model
        annonceAnnee.text = newObject.annee
        annonceEtat.text = newObject.etat
        
        
        carburantLabel.text = newObject.carburant
        kilometrageLabel.text = newObject.kilometrage
        transmissionLabel.text = newObject.transmissiom
        prixLabel.text = newObject.prix

        
        
    }


}
