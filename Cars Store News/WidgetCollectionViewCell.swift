//
//  widgetCollectionViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 22/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {
    
    
    var newsObject: News! {
        didSet{
            
            updateUI()
            
        }
    }
    
    
    
    // Mark Private
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel : UILabel!
    
    
    
    private func updateUI() {
        newsTitleLabel.text = newsObject.title
        let photoURL = newsObject.thumbnailUrl
        
        if photoURL != nil {
            let imageUrl:URL = photoURL!
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.newsImage.image = image
                    ///carImage.contentMode = UIViewContentMode.scaleAspectFit
                    
                }
            }
        }
        
    }
    

    
}
