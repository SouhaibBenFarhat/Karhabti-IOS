//
//  FavorisListViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 19/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class FavorisListNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension FavorisListNavigationController: MIPivotRootPage {
    
    func imageForPivotPage() -> UIImage? {
        return UIImage(named: "used")
    }
    
}
