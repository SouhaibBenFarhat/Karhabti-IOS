//
//  CoverTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 26/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import Firebase

class CoverTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        circularView.layer.cornerRadius = circularView.frame.size.width/2
        circularView.clipsToBounds = true
        circularView.layer.borderColor = UIColor(red: 231, green: 76, blue: 60, alpha: 1).cgColor
        circularView.layer.borderWidth = 2.0
        
        
        circularView.layer.shadowColor = UIColor.black.cgColor
        circularView.layer.shadowOffset = CGSize(width: 3, height: 3)
        circularView.layer.shadowOpacity = 1
        circularView.layer.shadowRadius = 4.0

    
        if let user = FIRAuth.auth()?.currentUser
        {
            
            profilePicture.contentMode = .scaleAspectFit
            if user.photoURL != nil {
                downloadImage(url: user.photoURL!)
                
            }else{
                profilePicture.image = UIImage(named: "placeholder")
            }
            
            
        }
        
    }

    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.profilePicture.image = UIImage(data: data)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
