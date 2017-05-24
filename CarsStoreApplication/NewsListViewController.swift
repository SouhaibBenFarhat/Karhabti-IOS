//
//  NewsListViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 06/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage
import CDAlertView
class NewsListViewController: MIPivotPage, UITableViewDelegate, UITableViewDataSource {

    
    var articles = [Article]()
    var articlesImages = [UIImage]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        pivotPageController.menuView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupNavigationBar()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        articlesImages = appdelegate.articlesImages

        
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.articles = Article.downloadAllArticles()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                KRProgressHUD.dismiss({ 
                    if self.articles.count == 0{
                        CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
        

        
    }
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }

    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
 
    
    
    
    private func setupNavigationBar(){

        let myRedColor = UIColor(red: 234/255.0, green: 68/255.0, blue: 63/255.0, alpha: 1)
                self.navigationController!.isNavigationBarHidden = false
                self.navigationController!.navigationBar.backgroundColor = UIColor.clear
                self.navigationController?.navigationBar.isTranslucent = false
                let myGreyColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
                self.navigationController!.navigationBar.tintColor = myRedColor
                navigationController!.navigationBar.barTintColor = myGreyColor
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsTableViewCell
        cell.articleObject = articles[indexPath.row]
        cell.articleImage.sd_setImage(with: articles[indexPath.row].thumbnailUrl)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        detailViewController.article = articles[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
