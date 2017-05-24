//
//  GammeDetailViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 09/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage
import DTPhotoViewerController
import KRProgressHUD
import CDAlertView
import Firebase
import INSPhotoGallery
import ARSLineProgress


class GammeDetailViewController: MIPivotPage {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    var localSource = [ImageSource]()
    
    
    
    var gamme = Gamme()
    
    var gammeCaracteristique = [Caracteristique]()
    var gammeMotorisation = [Motorisation]()
    var gammeRaffinement = [Raffinement]()
    
    var caracteristique = Caracteristique()
    var motorisation = Motorisation()
    var raffinement = Raffinement()
    
    
    var gammePhotos = [GammePhoto]()
    var gammePhoto = UIImage()
    

    @IBOutlet weak var noImageImageView: UIImageView!
    @IBOutlet weak var gammePrix: UILabel!
    @IBOutlet weak var voirPhotoButton: UIButton!
    @IBOutlet weak var slideShowContainer: UIView!
    @IBOutlet weak var gammeDescription: UITextView!
    @IBOutlet weak var gammaPicture: UIImageView!
    @IBOutlet weak var gammeNameLabel: UILabel!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var loadingImageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    
    
    //caracteristique
    @IBOutlet weak var carrosserieText: UILabel!
    @IBOutlet weak var nombrePlaceText: UILabel!
    @IBOutlet weak var nombrePorteText: UILabel!
    @IBOutlet weak var longueurText: UILabel!
    @IBOutlet weak var largeurText: UILabel!
    @IBOutlet weak var VolumeCoffreText: UILabel!
    
    //motorisation
    @IBOutlet weak var nombreCylindreText: UILabel!
    @IBOutlet weak var energieText: UILabel!
    @IBOutlet weak var puissanceFiscalText: UILabel!
    @IBOutlet weak var puissanceChdinText: UILabel!
    @IBOutlet weak var coupleText: UILabel!
    @IBOutlet weak var cylindreeText: UILabel!
    @IBOutlet weak var consommationUrbaineText: UILabel!
    @IBOutlet weak var consommationMixteText: UILabel!
    @IBOutlet weak var zeroCentText: UILabel!
    @IBOutlet weak var vitesseMaxText: UILabel!
    
    
    //raffinement
    @IBOutlet weak var connectiviteText: UILabel!
    @IBOutlet weak var nombreAirBagText: UILabel!
    @IBOutlet weak var janteText: UILabel!
    @IBOutlet weak var climatisationText: UILabel!
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pivotPageController.menuView.clipsToBounds = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
     


    }
    
    

    @IBAction func showGalleryButton(_ sender: UIButton) {
        

        
        if Reachability.isConnectedToNetwork() {
            if gammePhotos.count > 0 {
                
                let galleryViewController = storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
                DispatchQueue.global(qos: .background).async {
                    KRProgressHUD.show()
                    for image in self.gammePhotos{
                        if let url = image.url {
                            if let data = NSData(contentsOf: url) {
                                let insPhoto = INSPhoto(image: UIImage(data: data as Data)!, thumbnailImage: UIImage(data: data as Data)!)
                                galleryViewController.photos.append(insPhoto)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        KRProgressHUD.dismiss()
                        self.navigationController?.pushViewController(galleryViewController, animated: true)
                    }
                }
                
                
            }else{
                
                CDAlertView(title: "Bientôt", message: "les images seront disponible prochainement " , type: .notification).show()
                
            }
        }else{
            self.connectivityAlert()
        }
        
        
    }
    
    func connectivityAlert() {
        CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
    }
    
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {

        if Reachability.isConnectedToNetwork() {
            let user = FIRAuth.auth()?.currentUser
            let uid = user!.uid
            var state = false
            
            
            DispatchQueue.global(qos: .background).async {
                state = Favoris.didFavorisExiste(idUser: uid, idGamme: self.gamme.id)
                
                DispatchQueue.main.async {
                    if state {
                        
                        ARSLineProgress.showFail()
                        self.view.makeToast(" Existe déja ", duration: 3.0, position: CGPoint(x: self.view.frame.width / 2 , y: self.view.frame.height - 75 ) , style: nil)
                        
                    }else{
                        
                        DispatchQueue.global(qos: .background).async {
                            _ = Favoris.addUserFavoris(idUser: uid, idGamme: self.gamme.id)
                            
                            DispatchQueue.main.async {
                                ARSLineProgress.showSuccess()
                                
                            }
                        }
                    }
                }
            }
        }else{
            self.connectivityAlert()
        }
    }
    
    

    override func viewDidLoad() {
        
      
        
        super.viewDidLoad()
        
        
        voirPhotoButton.layer.cornerRadius = 5
        voirPhotoButton.layer.borderWidth = 0
        voirPhotoButton.layer.borderColor = UIColor.white.cgColor
        voirPhotoButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        voirPhotoButton.layer.shadowOpacity = 0.3
        
        addToFavoriteButton.layer.cornerRadius = 5
        addToFavoriteButton.layer.borderWidth = 0
        addToFavoriteButton.layer.borderColor = UIColor.white.cgColor
        addToFavoriteButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        if gammeRaffinement.count != 0 && gammeCaracteristique.count != 0 && gammeMotorisation.count != 0 {
            caracteristique = gammeCaracteristique[0]
            motorisation = gammeMotorisation[0]
            raffinement = gammeRaffinement[0]
            loadingImageIndicator.isHidden = false
            loadingImageIndicator.hidesWhenStopped = true
            gammePrix.text = gamme.prix
            
            
  
            
            //write caracteristique
            carrosserieText.text = caracteristique.carrosserie
            nombrePlaceText.text = caracteristique.nombre_place
            nombrePorteText.text = caracteristique.nombre_porte
            longueurText.text = caracteristique.longueur
            largeurText.text = caracteristique.largeur
            VolumeCoffreText.text = caracteristique.volume_coffre
            
            //write motorisation
            nombreCylindreText.text = motorisation.nombre_cylindre
            energieText.text = motorisation.energie
            puissanceFiscalText.text = motorisation.puissance_fiscal
            puissanceChdinText.text = motorisation.puissance_chdin
            coupleText.text = motorisation.couple
            cylindreeText.text = motorisation.cylindree
            consommationMixteText.text = motorisation.consommation_mixte
            consommationUrbaineText.text = motorisation.consommation_urbaine
            zeroCentText.text = motorisation.zero_cent
            vitesseMaxText.text = motorisation.vitesse_max
            
            //write reffinement
            nombreAirBagText.text = raffinement.nombre_airbag
            connectiviteText.text = raffinement.connectivite
            climatisationText.text = raffinement.climatisation
            janteText.text = raffinement.jante
            
            
            
            
        }else{
KRProgressHUD.dismiss({ 
    CDAlertView( title: "Oups", message: "Probléme de connexion !", type: .warning).show()

})        }
        
        gammePhotos = GammePhoto.downloadAllPhotos(idd: gamme.id)
        if gammePhotos.count > 0 {
            noImageImageView.isHidden = true
            loadingImageIndicator.startAnimating()
            DispatchQueue.global(qos: .background).async {
                
                
                for image in self.gammePhotos{
                    if let url = image.url {
                        if let data = NSData(contentsOf: url) {
                            self.gammePhoto = UIImage(data: data as Data)!
                            self.localSource.append(ImageSource(image: self.gammePhoto))
                        }
                    }
                }
                DispatchQueue.main.async {
                    
                    self.slideshow.setImageInputs(self.localSource)
                    self.loadingImageIndicator.stopAnimating()
                }
            }
        }else{

           
      noImageImageView.isHidden = false
           
        }
        
        
        
        
        
        gammeNameLabel.text = gamme.gamme.trimmingCharacters(in: .whitespaces)
        setupSlideShow()
        setupGammeImage()
        gammeDescription.text = gamme.description.trimmingCharacters(in: .whitespaces)
     

      
    }
    
    
    func setupSlideShow(){
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray;
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black;
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.sizeToFit()
        slideshow.setImageInputs(localSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    func setupGammeImage(){
        if gammeRaffinement.count != 0 && gammeCaracteristique.count != 0 && gammeMotorisation.count != 0 {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: self.gamme.picture_url!)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.gammaPicture.image = image
            }
        }
        }
        
    }
    
    
    override func shouldShowPivotMenu() -> Bool {
        return false
    }
    override func pivotPageShouldHandleNavigation() -> Bool {
        return false
    }


    
    func didTap() {
        //slideshow.presentFullScreenController(from: self)
        if let viewController = DTPhotoViewerController(referenceView: self.slideshow, image:  slideshow.currentSlideshowItem?.imageView.image) {
            self.present(viewController, animated: true, completion: nil)
        }
    }

    
    
    
}
