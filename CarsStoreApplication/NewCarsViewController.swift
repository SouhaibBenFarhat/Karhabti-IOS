//
//  HomeViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 02/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//
import CDAlertView
import UIKit
import Firebase
import SDWebImage
import KRProgressHUD
import ARSLineProgress
class NewCarsViewController: MIPivotPage, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var chercheButton: UIButton!
    @IBOutlet weak var voirPlusMagazineButton: UIButton!
    @IBOutlet weak var voirPlusBrands: UIButton!
    @IBOutlet weak var voirPlusConcessionnaireButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!

    
    @IBOutlet weak var filterButton: UIButton!
    
    
    @IBOutlet weak var marqueDisponibleContainer: UIView!
    @IBOutlet weak var trouvezLaMeilleurContainer: UIView!
    @IBOutlet weak var lesPlusPopulaireContainer: UIView!
    @IBOutlet weak var ConcessionnaireContainer: UIView!
    
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var BrandCollectionView: UICollectionView!
    @IBOutlet weak var concessionnaireCollectionView: UICollectionView!
    
    @IBOutlet weak var circularView: UIView!
    
    
    var news = [Article]()
    var brands = [Brand]()
    var concessionnaire = [Concessionnaire]()

    
    
    var newsImages = [UIImage]()
    

    
    @IBAction func seeAllNewsButton(_ sender: UIButton) {
        
        
        if Reachability.isConnectedToNetwork() == true  {
            let allnewsViewController = storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
            self.navigationController!.pushViewController(allnewsViewController, animated: true)
        }
        


    
    }
    
    @IBAction func seeAllBrandsButton(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork() == true {
            let allbrandViewController = storyboard?.instantiateViewController(withIdentifier: "AllBrandsViewController") as! BrandListCollectionViewController
            self.navigationController?.pushViewController(allbrandViewController, animated: true)
        }

        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController!.setNavigationBarHidden(true, animated: true)
        pivotPageController.menuView.clipsToBounds = false
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    func realoadingAppData() {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            appdelegate.brands = Brand.downloadAllBrands()
            appdelegate.news = Article.downloadAllArticles()
            appdelegate.concessionnaire = Concessionnaire.downloadAllConcessionnaires()
            
            DispatchQueue.main.async {
                self.brands = appdelegate.brands
                self.news = appdelegate.news
                self.concessionnaire = appdelegate.concessionnaire
                self.newsImages = appdelegate.articlesImages
                
                self.newsCollectionView.reloadData()
                self.BrandCollectionView.reloadData()
                self.concessionnaireCollectionView.reloadData()
                
                KRProgressHUD.dismiss()
            }
        }
    }
    override func viewDidLoad() {
    
        
      super.viewDidLoad()

        
        
      navigationController?.setNavigationBarHidden(true, animated: true)
       
        
        
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.news.count == 0 || appDelegate.brands.count == 0 || appDelegate.concessionnaire.count == 0 {
            realoadingAppData()
        }else{
            brands = appDelegate.brands
            news = appDelegate.news
            concessionnaire = appDelegate.concessionnaire
            newsImages = appDelegate.articlesImages

        }
        
        
        
        
      pivotPageController.menuView.isUserInteractionEnabled = false
        
      setupNavigationBar()
      setupeFirstContainer()
      setupSecondContainer()
      setupThirdContainer()
      setupForthContainer()
        
        
    
        
        
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
    

    func setupeFirstContainer(){
    
        
        chercheButton.layer.cornerRadius = 5
        chercheButton.layer.borderWidth = 0
        chercheButton.layer.borderColor = UIColor.white.cgColor
        chercheButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        chercheButton.layer.shadowOpacity = 0.3
        
        trouvezLaMeilleurContainer.layer.borderWidth = 0.5
        trouvezLaMeilleurContainer.layer.borderColor = UIColor.red.cgColor
        trouvezLaMeilleurContainer.layer.cornerRadius = 5
        trouvezLaMeilleurContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        trouvezLaMeilleurContainer.layer.shadowOpacity = 0.3
    }
    
    func setupSecondContainer(){
        
        
        voirPlusMagazineButton.layer.cornerRadius = 5
        voirPlusMagazineButton.layer.borderWidth = 0
        voirPlusMagazineButton.layer.borderColor = UIColor.white.cgColor
        voirPlusMagazineButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        voirPlusMagazineButton.layer.shadowOpacity = 0.3
        
        lesPlusPopulaireContainer.layer.borderWidth = 0.5
        lesPlusPopulaireContainer.layer.borderColor = UIColor.red.cgColor
        lesPlusPopulaireContainer.layer.cornerRadius = 5
        lesPlusPopulaireContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        lesPlusPopulaireContainer.layer.shadowOpacity = 0.3
    }
    
    func setupThirdContainer(){
        
        voirPlusBrands.layer.cornerRadius = 5
        voirPlusBrands.layer.borderWidth = 0
        voirPlusBrands.layer.borderColor = UIColor.white.cgColor
        voirPlusBrands.layer.shadowOffset = CGSize(width: 0, height: 2)
        voirPlusBrands.layer.shadowOpacity = 0.3
        
        marqueDisponibleContainer.layer.borderWidth = 0.5
        marqueDisponibleContainer.layer.borderColor = UIColor.red.cgColor
        marqueDisponibleContainer.layer.cornerRadius = 5
        marqueDisponibleContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        marqueDisponibleContainer.layer.shadowOpacity = 0.3
    }

    
    
    func setupForthContainer(){
        
        voirPlusConcessionnaireButton.layer.cornerRadius = 5
        voirPlusConcessionnaireButton.layer.borderWidth = 0
        voirPlusConcessionnaireButton.layer.borderColor = UIColor.white.cgColor
        voirPlusConcessionnaireButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        voirPlusConcessionnaireButton.layer.shadowOpacity = 0.3
        
        ConcessionnaireContainer.layer.borderWidth = 0.5
        ConcessionnaireContainer.layer.borderColor = UIColor.red.cgColor
        ConcessionnaireContainer.layer.cornerRadius = 5
        ConcessionnaireContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        ConcessionnaireContainer.layer.shadowOpacity = 0.3
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
                return news.count
        }
        if collectionView.tag == 2 {
            return brands.count
        }
        if collectionView.tag == 3 {
            return concessionnaire.count
        }
        
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
            cell.newsObject = self.news[indexPath.item]
            cell.newsImage.sd_setImage(with: news[indexPath.row].thumbnailUrl)
            return cell
        }
        if collectionView.tag == 2   {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCollectionViewCell
            cell.newObject = self.brands[indexPath.item]
            cell.brandLogo.sd_setImage(with: brands[indexPath.row].logo)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConcessionnaireCell", for: indexPath) as! ConcessionnaireCollectionViewCell
            cell.newObject = self.concessionnaire[indexPath.item]
            cell.concessionnaireImg.sd_setImage(with: concessionnaire[indexPath.row].logo)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == newsCollectionView {
            let detailViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
            detailViewController.article = news[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
            
        }else if collectionView == BrandCollectionView{
            
            let modelListViewController = storyboard?.instantiateViewController(withIdentifier: "ModelsListViewController") as! ModelsListViewController
            
            
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.showText(message: "")
                 let nbModel = Model.downloadAllModels(idd: self.brands[indexPath.row].id).count
                
                DispatchQueue.main.async {
                    if nbModel > 0 {
                            KRProgressHUD.dismiss({ 
                                modelListViewController.modelBrand = self.brands[indexPath.row]
                                self.navigationController?.show(modelListViewController, sender: nil)
                            })
                        
                    }else{
                        if Reachability.isConnectedToNetwork() == false{
                            KRProgressHUD.dismiss({ 
                                CDAlertView(title: "Oups", message: "Probléme de connexion" , type: .warning).show()

                            })
                        }else{
                            KRProgressHUD.dismiss({CDAlertView(title: "Bientôt", message: "aucun model trouvé pour la marque " + self.brands[indexPath.row].name , type: .notification).show()})
                        }
                    }
                }
            }
            
        }else{
            let concessionnaireDetailViewController = storyboard?.instantiateViewController(withIdentifier: "ConcessionnaireDetailViewController") as! ConcessionnaireDetailViewController
            concessionnaireDetailViewController.concessionnaire = concessionnaire[indexPath.row]
            self.show(concessionnaireDetailViewController, sender: nil)
        }
    }
    
    private func setupNavigationBar(){
        
        
        let myRedColor = UIColor(red: 234/255.0, green: 68/255.0, blue: 63/255.0, alpha: 1)
        self.navigationController!.isNavigationBarHidden = true
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        let myGreyColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        self.navigationController!.navigationBar.tintColor = myRedColor
        navigationController!.navigationBar.barTintColor = myGreyColor
        
    }
}



