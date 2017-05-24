//
//  NewsTableViewCell.swift
//  CarsStoreApplication
//
//  Created by mac on 06/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var loadingProcessIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var category: UILabel!
    
    
    
    
    
    var articleObject: Article! {
        didSet{
            updateUI()
            loadingProcessIndicator.isHidden = true
           // loadingProcessIndicator.hidesWhenStopped = true
        }
    }
    private func updateUI(){
        loadingProcessIndicator.startAnimating()
        articleTitle.text = articleObject.title
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date as Date)
     
        
        category.text = articleObject.category
        newsDate.text = dateString

        

        
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
