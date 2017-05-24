//
//  SearchForAnnonceViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 28/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD
import CDAlertView

class SearchForAnnonceViewController: MIPivotPage, UITableViewDelegate, UITableViewDataSource  , UISearchBarDelegate, UISearchDisplayDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var annonces = [Annonce]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        searchBar.delegate = self
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                KRProgressHUD.show()
                let tmp = Annonce.downloadAllAnnonces()
   
                    
                
                
                DispatchQueue.main.async {
                    
                    self.annonces = tmp
                    KRProgressHUD.dismiss({ 
                        self.tableView.reloadData()
                    })
                   
                   
                    
                }
            }
        }else{
                CDAlertView(title: "Oups", message: "Probléme de connexion" , type: .warning).show()
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        

    
    
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
        
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
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
    
    func filterData() -> [Annonce]{
        
        if searchBar.text != "" {
            var filtredData = [Annonce]()
            for a in annonces{
                
                if (a.model.lowercased().contains(searchBar.text!.lowercased()) ) {
                    filtredData.append(a)
                }
            }
            
            return filtredData
            
        }else{
            return self.annonces
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        _ = filterData()
        tableView.reloadData()

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _ = filterData()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData().count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Reachability.isConnectedToNetwork() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAnnonceCell") as! AnnonceTableViewCell
            cell.newObject = filterData()[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else{
            return UITableViewCell()
        }
        
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork() {
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "AnnonceDetailViewController") as! AnnonceDetailViewController
            nextViewController.annonce = filterData()[indexPath.row]
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    
}
