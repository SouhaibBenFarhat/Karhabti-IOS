//
//  ProfileNavigationController.swift
//  CarsStoreApplication
//
//  Created by mac on 28/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension ProfileNavigationController: MIPivotRootPage {
    
    func imageForPivotPage() -> UIImage? {
        return UIImage(named: "used")
    }
    
}
