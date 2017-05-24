//
//  SharedMakesViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD


class SharedMakesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    
    var year : String = ""
    var sharedMakes = [SharedMakes]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.sharedMakes = SharedMakes.downloadSharedMakes(year: self.year)
            DispatchQueue.main.async {
            
              self.tableView.reloadData()
                KRProgressHUD.dismiss()
            }
        }
        
        
        searchBar.delegate = self


    }
    
    func filterData() -> [SharedMakes]{
        
        if searchBar.text != "" {
            var filtredData = [SharedMakes]()
            for make in sharedMakes{
                if (make.name.lowercased().contains(searchBar.text!.lowercased()) ) {
                    filtredData.append(make)
                }
            }
            
            return filtredData
            
        }else{
            return self.sharedMakes
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          _ = filterData()
         tableView.reloadData()
        print("text change")
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      

    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _ = filterData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarqueCell") as! MarqueTableViewCell
        cell.sharedMake = filterData()[indexPath.row]
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SellYourCarViewController.selectedMarqueValue = filterData()[indexPath.row]
        self.dismiss(animated: true, completion: nil)
        
    }
}
