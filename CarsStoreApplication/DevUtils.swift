//
//  DevUtils.swift
//  CarsStoreApplication
//
//  Created by mac on 13/01/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import UIKit
class Utils
{
    static let sharedUtils = Utils()
    
    class func showAlertOnVC(
        targetVC: UIViewController, title: String, message: String)
    {
        var title = title
        var message = message
        title = NSLocalizedString(title, comment: "")
        message = NSLocalizedString(message, comment: "")
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(
            title:"OK",
            style: UIAlertActionStyle.default,
            handler:
            {
                (alert: UIAlertAction!)  in
        })
        alert.addAction(okButton)
        targetVC.present(alert, animated: true, completion: nil)
    }
}
