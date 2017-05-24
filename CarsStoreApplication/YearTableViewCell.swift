//
//  YearTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class YearTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var yearLabel: UILabel!
    
    
    
    var year: MakeYears! {
        didSet{
            updateUI()
            
        }
    }
    private func updateUI(){
        
        yearLabel.text = year.year
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
