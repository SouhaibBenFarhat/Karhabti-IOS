//
//  ConcessionnaireCollectionViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 05/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ConcessionnaireCollectionViewCell: UICollectionViewCell {
 
    
    
    // Public
    var newObject: Concessionnaire! {
        didSet{
            updateUI()
        }
    }
    
    
    
    // Mark Private
    
    @IBOutlet weak var concessionnaireImg: UIImageView!
    @IBOutlet weak var concessinnaireName : UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    
    
    private func updateUI(){
        
        
        
        
        
        concessinnaireName.text = newObject.name

        

        
    }
    

    
    
}
