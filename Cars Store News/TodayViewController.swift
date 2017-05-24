//
//  TodayViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 22/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    var news = [News]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        news = News.downloadAllArticles()

        newsCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "widgetCell", for: indexPath) as! WidgetCollectionViewCell
        cell.newsObject = news[indexPath.row]
        print(news.count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let openURL = NSURL(string: "KARHABTIAPPnews")
        self.extensionContext?.open(openURL as! URL, completionHandler: nil)
        
    }


}
