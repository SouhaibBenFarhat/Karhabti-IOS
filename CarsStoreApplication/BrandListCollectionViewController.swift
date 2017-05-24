//
//  BrandListCollectionViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 06/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView
import CDAlertView
import KRProgressHUD
import ARSLineProgress

private let reuseIdentifier = "Cell"

class BrandListCollectionViewController: MIPivotPage, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var brands = [Brand]()

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        pivotPageController.menuView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.brands = Brand.downloadAllBrands()
            
            DispatchQueue.main.async {
               self.collectionView.reloadData()
                KRProgressHUD.dismiss({ 
                    if  self.brands.count == 0 {
                        CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
                      _ = self.navigationController?.popViewController(animated: true)

                    }
                })
            }
        }
        
        self.setupNavigationBar()

        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = collectionView.frame.width/3 - 1
        return CGSize (width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    



    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return brands.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCollectionViewCell
        cell.newObject = brands[indexPath.item]
        cell.brandLogo.sd_setImage(with: brands[indexPath.row].logo)
    
        // Configure the cell
    
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let modelListViewController = storyboard?.instantiateViewController(withIdentifier: "ModelsListViewController") as! ModelsListViewController
        modelListViewController.modelBrand = brands[indexPath.row]
        
        DispatchQueue.global(qos: .background).async {
          
            let nbModel = Model.downloadAllModels(idd: self.brands[indexPath.row].id).count

            
            DispatchQueue.main.async {
                if nbModel > 0 {
                    ARSLineProgress.showSuccess()
                    self.navigationController?.show(modelListViewController, sender: nil)
                    
                }else{
                
                    if Reachability.isConnectedToNetwork() == false {
                        CDAlertView(title: "Oups", message: "Probléme de connexion ! ", type: .warning).show()
                    }else{
                        CDAlertView(title: "Bientôt", message: "aucun model trouvé pour la marque " + self.brands[indexPath.row].name , type: .notification).show()
                    }
                    
                }

            }
        }
        
        
  
    }

}
