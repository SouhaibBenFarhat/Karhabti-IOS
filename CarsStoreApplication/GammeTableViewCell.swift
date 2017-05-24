//
//  GammeTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 09/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class GammeTableViewCell: UITableViewCell {

    @IBOutlet weak var gammeDescription: UITextView!
    @IBOutlet weak var gammeImageView: UIImageView!
    @IBOutlet weak var loadingProcessIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var gammePrix: UILabel!
    @IBOutlet weak var gammeName: UILabel!
    
    
    var gammeObject: Gamme! {
        didSet{
            updateUI()
            loadingProcessIndicator.isHidden = false
            loadingProcessIndicator.hidesWhenStopped = true
        }
    }
    private func updateUI(){
        loadingProcessIndicator.startAnimating()
        gammeName.text = gammeObject.gamme
        gammeDescription.text = gammeObject.description.trimmingCharacters(in: .whitespacesAndNewlines)
        gammePrix.text = gammeObject.prix + " DT"
        
        let photoURL = gammeObject.picture_url
        
        if photoURL != nil {
            let imageUrl:URL = photoURL!

                URLSession.shared.dataTask(with: imageUrl) { (data, response, error)-> Void in
                    if error != nil{
                        return
                    }
                    let image = UIImage(data: data! as Data)

                    DispatchQueue.main.async {
                        
                        self.gammeImageView.image = image
                        self.loadingProcessIndicator.stopAnimating()
                    }
                    }.resume()
   
        }

}
}
