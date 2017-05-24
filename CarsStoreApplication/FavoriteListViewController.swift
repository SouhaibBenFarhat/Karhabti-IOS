//
//  FavoriteListViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 19/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD
import CDAlertView
import ARSLineProgress
class FavoriteListViewController: MIPivotPage, UITableViewDelegate, UITableViewDataSource {

    
    var gammes = [Gamme]()

    @IBOutlet weak var favorisTableView: UITableView!
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        setupNavigationBar()
        
        DispatchQueue.global(qos: .background).async {

            KRProgressHUD.show()
            let user = FIRAuth.auth()?.currentUser
            self.gammes = Gamme.downloadGammeFavoris(idUser: (user?.uid)!)

            DispatchQueue.main.async {
               KRProgressHUD.dismiss({ 
                self.favorisTableView.reloadData()
                if self.gammes.count == 0{
                    CDAlertView(title: "Oups", message: "Votre liste des favoris est vide", type: .notification).show()
                }
               })

            }
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return gammes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GammeCell") as! GammeTableViewCell
        cell.gammeObject = gammes[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Reachability.isConnectedToNetwork() {
            let gammeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "GammeDetailViewController") as! GammeDetailViewController
            
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.show()
                gammeDetailViewController.gamme = self.gammes[indexPath.row]
                gammeDetailViewController.gammeCaracteristique = Caracteristique.downloadAllCaracteristiques(idd: self.gammes[indexPath.row].caracteristique_id)
                gammeDetailViewController.gammeMotorisation = Motorisation.downloadAllMotorisation(idd: self.gammes[indexPath.row].motorisation_id)
                gammeDetailViewController.gammeRaffinement = Raffinement.downloadRaffinement(idd: self.gammes[indexPath.row].raffinement_id)
                
                DispatchQueue.main.async {
                    KRProgressHUD.dismiss()
                    self.navigationController?.pushViewController(gammeDetailViewController, animated: true)
                }
            }
        }else{
             CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            if FIRAuth.auth()?.currentUser != nil {
                
                
                DispatchQueue.global(qos: .background).async {
                  //  KRProgressHUD.show()
                    var tmp = Favoris.deleteUserFavoris(idUser: (FIRAuth.auth()?.currentUser?.uid)!, idGamme: self.gammes[indexPath.row].id)
                    DispatchQueue.main.async {
                        
                        
                        
                        if tmp == true {
                                self.gammes = Gamme.downloadGammeFavoris(idUser: (FIRAuth.auth()?.currentUser?.uid)!)
                                self.favorisTableView.reloadData()
                                ARSLineProgress.showSuccess()
                            tmp = false
                            
                        }
                        
                        
                        else{
                            
                            KRProgressHUD.dismiss({ 
                                KRProgressHUD.showError()
                            })
                        }
                        if self.gammes.count == 0 {
                                CDAlertView(title: "Oups", message: "Votre liste des favoris est vide !" , type: .notification).show()
                        
                        }
                }
            }
               
            
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
