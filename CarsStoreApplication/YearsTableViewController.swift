//
//  YearsTableViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 23/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import KRProgressHUD

class YearsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var years = [MakeYears]()

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .default

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            KRProgressHUD.show()
            self.years = MakeYears.downloadYears()
            DispatchQueue.main.async {
               self.tableView.reloadData()
                KRProgressHUD.dismiss()
            }
        }
      
    }



    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return years.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath) as! YearTableViewCell
        cell.year = years[indexPath.row]
        

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SellYourCarViewController.selectedYearValue = years[indexPath.row]
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
