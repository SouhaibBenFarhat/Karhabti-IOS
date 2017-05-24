//
//  Pattern2ViewController.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage
import DTPhotoViewerController
import KRProgressHUD
import CDAlertView


 class GammeListViewController: MIPivotPage , UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
//    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        get {
//            return .portrait
//        }
//    }
    
    
    var localSource = [ImageSource]()
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?

    
    

    @IBOutlet weak var noImage: UIImageView!
    @IBOutlet weak var loadingProcess: UIActivityIndicatorView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var gammeTableView: UITableView!

    
    var model = Model()
    var modelPhotos = [ModelPhoto]()
    var gammes = [Gamme]()
    var photo = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        slideshow.isHidden = false
    }
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingProcess.isHidden = false
        loadingProcess.hidesWhenStopped = true
        loadingProcess.startAnimating()
        
        

            
        
        if modelPhotos.count > 0 {
            noImage.isHidden = true
            DispatchQueue.global(qos: .background).async {
                
                for image in self.modelPhotos{
                    if let url = image.url {
                        if let data = NSData(contentsOf: url) {
                            self.photo = UIImage(data: data as Data)!
                            self.localSource.append(ImageSource(image: self.photo))
                        }
                    }
                }
                DispatchQueue.main.async {
                    
                    self.slideshow.setImageInputs(self.localSource)
                    self.loadingProcess.stopAnimating()
                }
            }
        }else{
            noImage.isHidden = false
            //self.localSource.append(ImageSource(imageString: "car-under-cover")!)
        }
           
        
        
           self.navigationController?.setNavigationBarHidden(false, animated: true)
     
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray;
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black;
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)
        slideshow.sizeToFit()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(GammeListViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return gammes.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork() {
            KRProgressHUD.show()
            if tableView == gammeTableView {
                let gammeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "GammeDetailViewController") as! GammeDetailViewController
                
                
                
                
                
                DispatchQueue.global(qos: .background).async {
                    gammeDetailViewController.gamme = self.gammes[indexPath.row]
                    gammeDetailViewController.gammeCaracteristique = Caracteristique.downloadAllCaracteristiques(idd: self.gammes[indexPath.row].caracteristique_id)
                    gammeDetailViewController.gammeMotorisation = Motorisation.downloadAllMotorisation(idd: self.gammes[indexPath.row].motorisation_id)
                    gammeDetailViewController.gammeRaffinement = Raffinement.downloadRaffinement(idd: self.gammes[indexPath.row].raffinement_id)
                    
                    DispatchQueue.main.async {
                        KRProgressHUD.dismiss()
                        self.navigationController?.pushViewController(gammeDetailViewController, animated: true)
                    }
                }
                
                
            }
        }else{
           CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "GammeCell") as! GammeTableViewCell
            cell.gammeObject = gammes[indexPath.row]
        cell.selectionStyle = .none
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
     return 305

        
    }
    
    
    func didTap() {
        //slideshow.presentFullScreenController(from: self)
        
        
        if let viewController = DTPhotoViewerController(referenceView: self.slideshow, image:  slideshow.currentSlideshowItem?.imageView.image) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
}






    
    





