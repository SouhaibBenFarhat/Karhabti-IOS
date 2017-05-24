//
//  ConcessionnaireDetailViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 13/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CDAlertView


class ConcessionnaireDetailViewController: MIPivotPage {
    
    
    var concessionnaire = Concessionnaire()
    
    @IBOutlet weak var concessionnaireImage: UIImageView!
    @IBOutlet weak var concessionnaireName: UILabel!
    @IBOutlet weak var concessionnaireAddress: UILabel!
    @IBOutlet weak var concessionnaireNumTel: UILabel!
    @IBOutlet weak var concessionnaireNumFax: UILabel!
    @IBOutlet weak var concessionnaireWebSite: UILabel!
    @IBOutlet weak var concessionnaireDescription: UITextView!
    @IBOutlet var concessionnaireMapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var visitSiteWeb: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.setNavigationBarHidden(false, animated: true)
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
        setupMapPosition()
        loadingIndicator.isHidden = false
        loadingIndicator.hidesWhenStopped = true
    
        
        if Reachability.isConnectedToNetwork() == true {
            loadingIndicator.startAnimating()
            let photoURL = concessionnaire.logo
            if photoURL != nil {
                let imageUrl:URL = photoURL!
                
                    
                    
                    URLSession.shared.dataTask(with: imageUrl) { (data, response, error)-> Void in
                        if error != nil{
                            CDAlertView(title: "Oups", message: "Probléme de connexion" , type: .warning).show()
                            return
                        }
                        let image = UIImage(data: data! as Data)
                        DispatchQueue.main.async {
                            
                            self.concessionnaireImage.image = image
                            self.loadingIndicator.stopAnimating()
                            
                        }
                        }.resume()
                    
               
                
            }
        }else{
            CDAlertView(title: "Oups", message: "Probléme de connexion" , type: .warning).show()
        }

        
        concessionnaireName.text = concessionnaire.name
        concessionnaireAddress.text = concessionnaire.address
        concessionnaireNumTel.text = concessionnaire.num_tel
        concessionnaireNumFax.text = concessionnaire.num_fax
        concessionnaireDescription.text = concessionnaire.description
        concessionnaireWebSite.text = concessionnaire.webSite
        
        
        
        
        callButton.layer.cornerRadius = 5
        callButton.layer.borderWidth = 0
        callButton.layer.borderColor = UIColor.white.cgColor
        callButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        callButton.layer.shadowOpacity = 0.3
        
        
        
        visitSiteWeb.layer.cornerRadius = 5
        visitSiteWeb.layer.borderWidth = 0
        visitSiteWeb.layer.borderColor = UIColor.white.cgColor
        visitSiteWeb.layer.shadowOffset = CGSize(width: 0, height: 2)
        visitSiteWeb.layer.shadowOpacity = 0.3
    }

    @IBAction func callConcessionnaireAction(_ sender: UIButton) {
        
   
        let url:NSURL = NSURL(string: "tel://"+concessionnaire.num_tel)!
        UIApplication.shared.open(url as URL, options: ["":""], completionHandler: nil)
        print(concessionnaire.num_tel)
        
    }
    
    func setupMapPosition(){
        

        let location = CLLocationCoordinate2DMake(36.821593, 10.189805)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = concessionnaire.name
        annotation.subtitle = concessionnaire.address

        
        
   
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        concessionnaireMapView.setRegion(region, animated: true)
        concessionnaireMapView.addAnnotation(annotation)
        concessionnaireMapView.view(for: annotation)?.isHidden = false
        
        let yourAnnotationAtIndex = 0
        concessionnaireMapView.selectAnnotation(concessionnaireMapView.annotations[yourAnnotationAtIndex], animated: true)
        
        
        
    }
    

}
