//
//  SharedModelsTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class SharedModelsTableViewCell: UITableViewCell {

    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var modelYear: UILabel!
    @IBOutlet weak var makeName: UILabel!

    
    
    var sharedModel: SharedModel! {
        didSet{
            updateUI()
            
        }
    }
    private func updateUI(){
        
        modelLabel.text = sharedModel.name
        modelYear.text = sharedModel.model_year
        makeName.text = sharedModel.make_name
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
