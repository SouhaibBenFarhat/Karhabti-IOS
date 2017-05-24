//
//  ViewController.swift
//  MRArticleViewController
//
//  Created by Matthew Rigdon on 08/16/2016.
//  Copyright (c) 2016 Matthew Rigdon. All rights reserved.
//

import UIKit
import Social
import CDAlertView
class NewsDetailViewController: MIPivotPage {
    
    var article = Article()
  
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newsDate: UILabel!

    @IBOutlet weak var newsBody: UITextView!
    
    @IBOutlet weak var voirPlusButton: UIButton!
    @IBOutlet weak var partagerSurFacebook: UIButton!
    @IBOutlet weak var partagerSurTwitter: UIButton!
    
    
    
    @IBAction func shareOnFacebookButton(_ sender: Any) {
        
        
        
        let shareActionSheet = UIAlertController( title: nil, message: "Partager ce contenu avec Facebook", preferredStyle: .actionSheet)
        let facebookShareAction = UIAlertAction(title: "FaceBook", style: .default, handler: { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookComposer?.setInitialText(self.article.title)
                facebookComposer?.add(self.newImage.image)
                facebookComposer?.add(self.article.link)
                self.present(facebookComposer!, animated: true, completion: nil)
                
                
            }else{
                self.alert(title: " Facebook non Disponible", msg: " Assurez vous que votre compte Facebook est disponible sur cette appareille ")
            }
            
        } )
        
        let cancelAction = UIAlertAction(title: "Retour", style: .cancel, handler: nil)
        shareActionSheet.addAction(facebookShareAction)
        shareActionSheet.addAction(cancelAction)
        self.present(shareActionSheet, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    @IBAction func shareOnTwitterAction(_ sender: UIButton) {
        
        
        let shareActionSheet = UIAlertController( title: nil, message: "Partager ce contenu avec Twitter", preferredStyle: .actionSheet)
        let twitterShareAction = UIAlertAction(title: "Twitter", style: .default, handler: { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetComposer?.setInitialText(self.article.title)
                tweetComposer?.add(self.newImage.image)
                self.present(tweetComposer!, animated: true, completion: nil)
                
                
            }else{
                self.alert(title: " Twitter non Disponible", msg: " Assurez vous que votre compte twitter est disponible sur cette appareille ")
            }
        
        } )
        
        let cancelAction = UIAlertAction(title: "Retour", style: .cancel, handler: nil)
        shareActionSheet.addAction(cancelAction)
        shareActionSheet.addAction(twitterShareAction)
        self.present(shareActionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goToBrowserAction(_ sender: UIButton) {
   UIApplication.shared.open(NSURL(string: (article.link?.absoluteString)!)! as URL, options: ["":""], completionHandler: nil)
        

    }
    
    
    func alert( title: String, msg: String )
    {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: " Ok ", style: .default))
        self.present(alertVC, animated: true, completion: nil)
      
    }
    
    
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
        //Customise web button
        
        if Reachability.isConnectedToNetwork() == false {
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
        voirPlusButton.layer.cornerRadius = 5
        voirPlusButton.layer.borderWidth = 0
        voirPlusButton.layer.borderColor = UIColor.white.cgColor
        voirPlusButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        voirPlusButton.layer.shadowOpacity = 0.3
        
        
        
        // Customise Facebook button
        partagerSurFacebook.layer.cornerRadius = 5
        partagerSurFacebook.layer.borderWidth = 0
        partagerSurFacebook.layer.borderColor = UIColor.white.cgColor
        partagerSurFacebook.layer.shadowOffset = CGSize(width: 0, height: 2)
        partagerSurFacebook.layer.shadowOpacity = 0.3
        
        
        //Customise Twitter Button
        partagerSurTwitter.layer.cornerRadius = 5
        partagerSurTwitter.layer.borderWidth = 0
        partagerSurTwitter.layer.borderColor = UIColor.white.cgColor
        partagerSurTwitter.layer.shadowOffset = CGSize(width: 0, height: 2)
        partagerSurTwitter.layer.shadowOpacity = 0.3
        
        
        if let url = article.thumbnailUrl {
            if let data = NSData(contentsOf: url) {
                newImage.image = UIImage(data: data as Data)!
                
            }        
        }
        
        newsTitle.text = article.title
        author.text = article.category
        newsBody.text  = article.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

//        authorColor = UIColor(red: 234/255.0, green: 68/255.0, blue: 63/255.0, alpha: 1)
        
   

    }



}

