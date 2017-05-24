//
//  SharedModelsViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD

class SharedModelsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    var sharedModels = [SharedModel]()
    var year = ""
    var make_id = ""

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        
        
        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.sharedModels = SharedModel.downloadSharedModels(make_year: self.year, make_id: self.make_id)

            DispatchQueue.main.async {
                self.tableView.reloadData()
                KRProgressHUD.dismiss()
            }
        }
        
        
        

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedModelCell") as! SharedModelsTableViewCell
        cell.sharedModel = sharedModels[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SellYourCarViewController.selectedModelValue = sharedModels[indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }
}
