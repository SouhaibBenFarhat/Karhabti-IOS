//
//  AnnonceDetailViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 26/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage
import DTPhotoViewerController
import KRProgressHUD
import INSPhotoGallery
import CDAlertView
import Firebase
import ARSLineProgress
import SCLAlertView

class AnnonceDetailViewController: MIPivotPage {

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    var localSource = [ImageSource]()
    var annonce = Annonce()
    var annoncePhotos = [AnnoncePhoto]()
    var annoncePhoto = UIImage()
    
    
    
    
    
    @IBOutlet weak var annonceCategory: UILabel!
    @IBOutlet weak var loadingProcess: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var annonceDescriptionTextView: UITextView!
    @IBOutlet weak var annoncePrix: UILabel!
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var annonceModelLabel: UILabel!
    @IBOutlet weak var kilometrageLabel: UILabel!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var annonceCarburantLabel: UILabel!
    @IBOutlet weak var annonceAnnee: UILabel!
    @IBOutlet weak var puissacneFiscalLabel: UILabel!
    @IBOutlet weak var annonceNombrePorte: UILabel!
    @IBOutlet weak var dateDeMiseEnCirculationLabel: UILabel!
    @IBOutlet weak var annonceEtatLabel: UILabel!
    @IBOutlet weak var annonceNumTel: UILabel!
    @IBOutlet weak var datePublication: UILabel!
    @IBOutlet weak var SupprimerAnnonceButton: UIButton!
    
    
    @IBAction func DeleteAnnonceAction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork() {
            let alert = SCLAlertView()
            alert.addButton("Oui") {
                
                
                DispatchQueue.global(qos: .background).async {
                    Annonce.deleteUserAnnonce(annonceId: self.annonce.id)
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)

                    }
                }
                
                
                
            }
            alert.showSuccess("", subTitle: "Voulez-vous supprimer?", closeButtonTitle: "Non", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
        }else{
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == false {
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
        
        loadingProcess.hidesWhenStopped = true
        loadingProcess.startAnimating()
        annoncePrix.text = annonce.prix
        annonceDescriptionTextView.text = annonce.autreDescription
        annonceModelLabel.text = annonce.model
        kilometrageLabel.text = annonce.kilometrage
        transmissionLabel.text = annonce.transmissiom
        annonceCarburantLabel.text = annonce.carburant
        annonceAnnee.text = annonce.annee
        puissacneFiscalLabel.text = annonce.puissance_fiscal
        annonceNombrePorte.text = annonce.nombrePorte
        dateDeMiseEnCirculationLabel.text = annonce.date_mise_circulation
        annonceEtatLabel.text = annonce.etat
        annonceNumTel.text = annonce.num_tel
        datePublication.text = annonce.date_publication
        annonceCategory.text = annonce.category
        
        if annonce.user_id == FIRAuth.auth()?.currentUser?.uid {
            SupprimerAnnonceButton.isHidden = false
        }else{
            SupprimerAnnonceButton.isHidden = true
        }
        
        SupprimerAnnonceButton.layer.cornerRadius = 5
        SupprimerAnnonceButton.layer.borderWidth = 0
        SupprimerAnnonceButton.layer.borderColor = UIColor.white.cgColor
        SupprimerAnnonceButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        SupprimerAnnonceButton.layer.shadowOpacity = 0.3
        
        
        annonceDescriptionTextView.layer.cornerRadius = 5
        annonceDescriptionTextView.layer.borderWidth = 1
        annonceDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        annonceDescriptionTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        annonceDescriptionTextView.layer.shadowOpacity = 0.3
        
        
        DispatchQueue.global(qos: .background).async {
            
            let brandLogoUrl = NSURL( string :BrandLogo.downloadBrandLogo(brand_id: self.annonce.brand_id)[0].logo)
            let data = try? Data(contentsOf: brandLogoUrl as! URL)
            self.brandLogo.image = UIImage(data: data!)
            let tmp = AnnoncePhoto.downloadAnnoncesPhotos(annonce_id: self.annonce.id)
            
            
            DispatchQueue.main.async {
                self.annoncePhotos = tmp
                if self.annoncePhotos.count > 0 {
                    
                    
                    
                    
                    for image in self.annoncePhotos{
                        let filename = image.file_name
                        FIRStorage.storage().reference().child("annonces_photos").child(filename).downloadURL(completion: { (url,error) in
                            if error != nil{
                                print(error ?? "")
                                return
                            }
                            DispatchQueue.global(qos: .background).async {
                                
                                let thumbnailData:NSData = NSData(contentsOf: url!)!
                                self.annoncePhoto  = UIImage(data: thumbnailData as Data)!
                                //self.image.image = self.annoncePhoto
                                self.localSource.append(ImageSource(image: self.annoncePhoto))
                                DispatchQueue.main.async {
                                    self.setupSlideShow()
                                    self.loadingProcess.startAnimating()
                                }
                            }
                        })
                        
                        
                    }
                    
                }

            }
        }
        
        
        
       

    print(self.localSource.count)
   
    }
    
    
    func setupSlideShow(){
        
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 5.0
        slideShow.pageControlPosition = PageControlPosition.insideScrollView
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray;
        slideShow.pageControl.pageIndicatorTintColor = UIColor.black;
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        slideShow.sizeToFit()
        slideShow.setImageInputs(localSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideShow.addGestureRecognizer(recognizer)
    }

    
    
    func didTap() {
        //slideshow.presentFullScreenController(from: self)
        if let viewController = DTPhotoViewerController(referenceView: self.slideShow, image:  slideShow.currentSlideshowItem?.imageView.image) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
