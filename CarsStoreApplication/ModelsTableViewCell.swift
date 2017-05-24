//
//  ModelsTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 07/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ModelsTableViewCell: UITableViewCell {

    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var loadingProcess: UIActivityIndicatorView!
    @IBOutlet weak var modelDescription: UILabel!
    
    @IBOutlet weak var modelPrice: UILabel!
    
    
    // Public
    var newObject: Model! {
        didSet{
            loadingProcess.hidesWhenStopped = true
            loadingProcess.startAnimating()
            loadingProcess.stopAnimating()
            updateUI()
        }
    }
  
    private func updateUI(){
 
        modelPrice.text = newObject.price_from + " DT "
        modelDescription.text = newObject.description
        modelName.text = newObject.name

        
    }
    
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
