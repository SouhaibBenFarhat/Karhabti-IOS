//
//  ConcessionnaireTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 12/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ConcessionnaireTableViewCell: UITableViewCell {

    
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
    @IBOutlet weak var concessionnaireDescription: UILabel!
    @IBOutlet weak var concessionnaireAdress: UILabel!
    @IBOutlet weak var concessionnaireNumTel: UILabel!
    @IBOutlet weak var loadingProcessIndicator: UIActivityIndicatorView!
    
    
    
    private func updateUI(){
        
 
        loadingProcessIndicator.isHidden = false
        loadingProcessIndicator.hidesWhenStopped = true
        //loadingProcessIndicator.startAnimating()
        
        
        concessinnaireName.text = newObject.name
        concessionnaireDescription.text = newObject.description
        concessionnaireAdress.text = newObject.address
        concessionnaireNumTel.text = newObject.num_tel
        
        //concessinnaireName.isHidden = true
        

        
    }

}
