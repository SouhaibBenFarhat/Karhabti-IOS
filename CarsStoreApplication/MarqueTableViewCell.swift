//
//  MarqueTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class MarqueTableViewCell: UITableViewCell {

    
    @IBOutlet weak var marqueLabel: UILabel!
    @IBOutlet weak var makelogo: UIImageView!
    
    
    
    var sharedMake: SharedMakes! {
        didSet{
            updateUI()
            
        }
    }
    private func updateUI(){
        
        marqueLabel.text = sharedMake.name
        
        let photoURL = sharedMake.logo
        
        if photoURL != "" {
            let imageUrl:URL = NSURL(string : photoURL)! as URL
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.makelogo.image = image
                    
                }
            }
        }
        
        
        
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
