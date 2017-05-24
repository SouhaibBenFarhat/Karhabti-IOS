//
//  NewsCollectionViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 04/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView

class NewsCollectionViewCell: UICollectionViewCell {
    
    // Public 
    var newsObject: Article! {
        didSet{
         
              updateUI()
           
        }
    }
    
    
    
    // Mark Private 
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel : UILabel!
    
    
    
    private func updateUI() {
        newsTitleLabel.text = newsObject.title

        
    }
    
    
    
    
    
    
    
    
    
    
    
}
