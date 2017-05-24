//
//  ConcessionnaireListViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 12/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD
import CDAlertView

class ConcessionnaireListViewController: MIPivotPage, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var concessionnaireTableView: UITableView!
    var concessionnaires = [Concessionnaire]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        pivotPageController.menuView.clipsToBounds = true
    }
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.concessionnaires = Concessionnaire.downloadAllConcessionnaires()

            
            DispatchQueue.main.async {
                self.concessionnaireTableView.reloadData()
                KRProgressHUD.dismiss({ 
                    if self.concessionnaires.count == 0{
                        CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
        

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
        return concessionnaires.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concessionnaireCell") as! ConcessionnaireTableViewCell
        cell.newObject = concessionnaires[indexPath.row]
        cell.concessionnaireImg.sd_setImage(with: concessionnaires[indexPath.row].logo)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let concessionnaireDetailViewController = storyboard?.instantiateViewController(withIdentifier: "ConcessionnaireDetailViewController") as! ConcessionnaireDetailViewController
        concessionnaireDetailViewController.concessionnaire = concessionnaires[indexPath.row]
        self.show(concessionnaireDetailViewController, sender: nil)
        
        
    }
    
    


}
