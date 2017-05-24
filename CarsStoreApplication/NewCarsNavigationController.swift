//
//  NavigViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 06/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class NewCarsNavigationController:  UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }




}
extension NewCarsNavigationController: MIPivotRootPage {
    
    func imageForPivotPage() -> UIImage? {
        return UIImage(named: "new")
    }
    
}
