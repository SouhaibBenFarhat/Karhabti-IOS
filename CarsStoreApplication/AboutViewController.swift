//
//  AboutViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 10/01/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var retourButton: UIButton!
    
    @IBOutlet weak var firas: UIImageView!
    @IBOutlet weak var souhaib: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firas.layer.cornerRadius = firas.frame.size.width/2
        firas.clipsToBounds = true
        firas.layer.borderColor = UIColor(red: 231, green: 76, blue: 60, alpha: 1).cgColor
        firas.layer.borderWidth = 2.0
        
        
        firas.layer.shadowColor = UIColor.black.cgColor
        firas.layer.shadowOffset = CGSize(width: 3, height: 3)
        firas.layer.shadowOpacity = 1
        firas.layer.shadowRadius = 4.0
        
        
        
        
        souhaib.layer.cornerRadius = firas.frame.size.width/2
        souhaib.clipsToBounds = true
        souhaib.layer.borderColor = UIColor(red: 231, green: 76, blue: 60, alpha: 1).cgColor
        souhaib.layer.borderWidth = 2.0
        
        
        souhaib.layer.shadowColor = UIColor.black.cgColor
        souhaib.layer.shadowOffset = CGSize(width: 3, height: 3)
        souhaib.layer.shadowOpacity = 1
        souhaib.layer.shadowRadius = 4.0
        
        
        
        
        iconImage.layer.cornerRadius = 5
        iconImage.layer.borderWidth = 0
        iconImage.layer.borderColor = UIColor.white.cgColor
        iconImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        iconImage.layer.shadowOpacity = 0.3
        
        
        retourButton.layer.cornerRadius = 5
        retourButton.layer.borderWidth = 0
        retourButton.layer.borderColor = UIColor.white.cgColor
        retourButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        retourButton.layer.shadowOpacity = 0.3


    }


    @IBAction func retourAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
