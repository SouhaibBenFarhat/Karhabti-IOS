//
//  MesAnnonceViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 28/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD
import CDAlertView

class MesAnnonceViewController: MIPivotPage, UITableViewDelegate, UITableViewDataSource {

    var mesAnnonces = [Annonce]()
    var brandLogos = [UIImage]()

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var mesAnnonceTableView: UITableView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        pivotPageController.menuView.clipsToBounds = true
        self.mesAnnonces.removeAll()
        self.brandLogos.removeAll()
        if Reachability.isConnectedToNetwork() {
            
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.show()
              
                self.mesAnnonces = Annonce.downloadUserAnnonce(idUser: (FIRAuth.auth()?.currentUser?.uid)!)
                
                for a in self.mesAnnonces{
                    let url = BrandLogo.downloadBrandLogo(brand_id: a.brand_id)[0].logo
                    let data = try? Data(contentsOf: NSURL(string: url) as! URL)
                    self.brandLogos.append(UIImage(data: data!)!)
                }
                
                DispatchQueue.main.async {
                    self.mesAnnonces.insert(Annonce(), at: 0)
                    self.brandLogos.insert(UIImage(), at: 0)
                    self.mesAnnonceTableView.reloadData()
                    KRProgressHUD.dismiss({ 
                        if self.mesAnnonces.count == 1{
                            CDAlertView(title: "Oups", message: "Aucune annonce publier de votre part !" , type: .notification).show()
                            
                        }

                    })
                    
                }
            }
        }else{
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesAnnonces.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.row == 0 {
            tableView.rowHeight = 212
            let cell = tableView.dequeueReusableCell(withIdentifier: "MesAnnonceCoverCell") as! CoverTableViewCell
            cell.selectionStyle = .none
            return cell
        }else{
            tableView.rowHeight = 212
            let cell = tableView.dequeueReusableCell(withIdentifier: "MesAnnonceCell") as! AnnonceTableViewCell
            if mesAnnonces.count != 0 {
                cell.newObject = mesAnnonces[indexPath.row]
                cell.brandLogo.image = brandLogos[indexPath.row]
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "AnnonceDetailViewController") as! AnnonceDetailViewController
            nextViewController.annonce = mesAnnonces[indexPath.row]
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

}
