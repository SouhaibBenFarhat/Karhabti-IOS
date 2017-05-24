//
//  UsedCarsViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 04/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView
import KRProgressHUD

class UsedCarsViewController: MIPivotPage, UITableViewDataSource, UITableViewDelegate  {
    
    
    var annonces = [Annonce]()
    var brandLogos = [UIImage]()
    @IBOutlet weak var annonceTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.show()
                self.annonces = Annonce.downloadAllAnnonces()
                self.brandLogos.removeAll()
                for a in self.annonces{
                    let url = BrandLogo.downloadBrandLogo(brand_id: a.brand_id)[0].logo
                    let data = try? Data(contentsOf: NSURL(string: url) as! URL)
                    self.brandLogos.append(UIImage(data: data!)!)
                }
                DispatchQueue.main.async {
                    
                    
                    KRProgressHUD.dismiss({ 
                        self.annonces.insert(Annonce(), at: 0)
                        self.brandLogos.insert(UIImage(), at: 0)
                        self.annonceTableView.reloadData()
                    })
                    
                }
            }
        }else{
            
            self.connectivityAlert()
           
            
        }
        
        
     
        setupNavigationController()

    }
    
    func connectivityAlert() {
        let alert = SCLAlertView()
        alert.addButton("OK") {
            self.loadData()
        }
        alert.showError("Oups", subTitle: "Une connexion internet est requise", closeButtonTitle: "RETOUR", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
    }
    
    func loadData(){
        if Reachability.isConnectedToNetwork() == true{
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.show()
                self.annonces = Annonce.downloadAllAnnonces()
                self.brandLogos.removeAll()
                for a in self.annonces{
                    let url = BrandLogo.downloadBrandLogo(brand_id: a.brand_id)[0].logo
                    let data = try? Data(contentsOf: NSURL(string: url) as! URL)
                    self.brandLogos.append(UIImage(data: data!)!)
                }
                DispatchQueue.main.async {
                    
                 
                    KRProgressHUD.dismiss({ 
                        self.annonces.insert(Annonce(), at: 0)
                        self.brandLogos.insert(UIImage(), at: 0)
                        self.annonceTableView.reloadData()
                    })
                    
                }
            }
        }else{
            self.connectivityAlert()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
     //   annonceTableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverCell")

    }


    func setupNavigationController() {
        
        let myRedColor = UIColor(red: 234/255.0, green: 68/255.0, blue: 63/255.0, alpha: 1)
        self.navigationController!.isNavigationBarHidden = true
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
        return annonces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            tableView.rowHeight = 148
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverCell")
            cell?.selectionStyle = .none
            return cell!

        }else {
            tableView.rowHeight = 212
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnnonceCell") as! AnnonceTableViewCell
            cell.newObject = annonces[indexPath.row]
            cell.brandLogo.image = brandLogos[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
       
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "AnnonceDetailViewController") as! AnnonceDetailViewController
            nextViewController.annonce = annonces[indexPath.row]
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
    }
}

