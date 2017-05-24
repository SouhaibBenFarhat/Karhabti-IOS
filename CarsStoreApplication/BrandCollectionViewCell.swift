//
//  BrandCollectionViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 04/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView


class BrandCollectionViewCell: UICollectionViewCell {
    
    // Public
    var newObject: Brand! {
        didSet{
            do{
             try updateUI()
            }
            catch {
                SCLAlertView().showError("Erreur de chargement", subTitle: "Merci de verifier votre connexion Internert") // Error
            }
        }
    }
    
    
    
    // Mark Private
    
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var brandTitleLabel : UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    
    
    private func updateUI() throws {
        
        
        
        
        
        brandTitleLabel.text = newObject.name
        
            
            
        }
        
    }


