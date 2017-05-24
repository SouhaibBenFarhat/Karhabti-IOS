//
//  ImageCollectionViewCell.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var loadingProcess: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "ImageCollectionViewCell"
    static let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    var modelPhoto = ModelPhoto()
    var modelImage = UIImage()
    func configure(indexPath: IndexPath) {
        loadingProcess.isHidden = true
        loadingProcess.hidesWhenStopped = true
        loadingProcess.startAnimating()
        
//        let photoURL = modelPhoto.url
//        
//        if photoURL != nil {
//            let imageUrl:URL = photoURL!
//            
//            // Start background thread so that image loading does not make app unresponsive
//            DispatchQueue.global(qos: .userInitiated).async {
//                
//                let imageData:NSData = NSData(contentsOf: imageUrl)!
//                
//                
//                // When from background thread, UI needs to be updated on main_queue
//                DispatchQueue.main.async {
//                    let image = UIImage(data: imageData as Data)
//                    self.imageView.image = image
//                    self.loadingProcess.stopAnimating()
//                    ///carImage.contentMode = UIViewContentMode.scaleAspectFit
//                    
//                }
//            }
//        }
        imageView.image = modelImage
        loadingProcess.stopAnimating()
        self.reloadInputViews()

     
    }
}
