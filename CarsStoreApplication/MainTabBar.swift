//
//  NewCarsSectionViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 05/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import CDAlertView
import KRProgressHUD
import FBSDKLoginKit
import GoogleSignIn

class MainTabBar: UITabBarController,  UITabBarControllerDelegate  {

 var loginRegisterNavigationController = LoginRegisterNavigationController()
 var favoriteListPivotpage = MIPivotPageController()
    var profilePivotpage = MIPivotPageController()
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        UIApplication.shared.statusBarStyle = .lightContent
        
        let myGreyColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let newCarsViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewCarsViewController") as! NewCarsViewController
        
        let newCarsNavigationController = NewCarsNavigationController(rootViewController: newCarsViewController)
        let usedCarsViewController = mainStoryboard.instantiateViewController(withIdentifier: "UsedCarsViewController") as! UsedCarsViewController
        let usedCarsNavigationController = UsedCarsNavigationController(rootViewController : usedCarsViewController)
        
        let pivotPageController = MIPivotPageController.get(rootPages: [newCarsNavigationController, usedCarsNavigationController]) {
            $0.menuView.backgroundColor = myGreyColor
            $0.menuView.layer.shadowColor = UIColor.black.cgColor
            $0.menuView.layer.shadowOpacity = 0.3
            $0.menuView.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.setMenuHeight(50)
            $0.setLightStatusBar(true)
        }
        
        
        
        
        let favoriteListNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "FavorisListNavigationController") as! FavorisListNavigationController
        favoriteListPivotpage  = MIPivotPageController.get(rootPages: [favoriteListNavigationController]) {
            $0.menuView.backgroundColor = myGreyColor
            $0.menuView.layer.shadowColor = UIColor.black.cgColor
            $0.menuView.layer.shadowOpacity = 0.3
            $0.menuView.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.setMenuHeight(0)
            $0.setLightStatusBar(true)
        }
        
        let profileNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! ProfileNavigationController
            profilePivotpage  = MIPivotPageController.get(rootPages: [profileNavigationController]) {
            $0.menuView.backgroundColor = myGreyColor
            $0.menuView.layer.shadowColor = UIColor.black.cgColor
            $0.menuView.layer.shadowOpacity = 0.3
            $0.menuView.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.setMenuHeight(0)
            $0.setLightStatusBar(true)
        }
        
        
        
        
        
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "SecondViewController") as! SellYourCarViewController
        loginRegisterNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "LoginRegisterNavigationController") as! LoginRegisterNavigationController
        let icon1 = UITabBarItem(title: "Accueil", image: UIImage(named: "home"), selectedImage: UIImage(named: "selected_home"))
        let icon4 = UITabBarItem(title: "Favoris", image: UIImage(named: "favoris"), selectedImage: UIImage(named: "selected_favoris"))
        let icon2 = UITabBarItem(title: "Plus", image: UIImage(named: "add_annonce"), selectedImage: UIImage(named: "selected_add_annonce"))
        let icon5 = UITabBarItem(title: "Profile", image: UIImage(named: "profile-1"), selectedImage: UIImage(named: "selected_profile"))
        let icon3 = UITabBarItem(title: "Déconnexion", image: UIImage(named: "logout"), selectedImage: UIImage(named: "selected_logout"))
        let navigationView = UINavigationController(rootViewController: secondViewController)
        
        
        
        
        pivotPageController.tabBarItem = icon1
        navigationView.tabBarItem = icon2
        loginRegisterNavigationController.tabBarItem = icon3
        favoriteListPivotpage.tabBarItem = icon4
        profilePivotpage.tabBarItem = icon5
        
        
        
        
        self.viewControllers = [pivotPageController, favoriteListPivotpage, navigationView, profilePivotpage, loginRegisterNavigationController]
        UITabBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.black, size: CGSize(width: tabBar.frame.width/5, height:  tabBar.frame.height))
        for item in self.tabBar.items! {
            if let image = item.image {
                item.image = image.withRenderingMode(.alwaysOriginal)
            }
        }

        
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == loginRegisterNavigationController {
            
            let alert = SCLAlertView()
            alert.addButton("Oui") {
                 try! FIRAuth.auth()!.signOut()
                let loginManager = FBSDKLoginManager()
                GIDSignIn.sharedInstance().signOut()
                loginManager.logOut()
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.showSuccess("", subTitle: "Voulez-vous quitter?", closeButtonTitle: "Non", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
            
            
              return false
        }
        
        
        
        else if viewController == favoriteListPivotpage  {
        
        
            
            
            
            if Reachability.isConnectedToNetwork() == true{
               return true
                

            }else {
                CDAlertView(title: "Oups", message: "Probléme de connexion" , type: .warning).show()
                return false
            }
            
        }else{
          return true
        }
    }
    
  


}

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
