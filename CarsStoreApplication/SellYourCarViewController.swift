//
//  ViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 05/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import SCLAlertView
import KRProgressHUD
import PopupDialog
import Firebase
import CDAlertView

class SellYourCarViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate, SCPopDatePickerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    

    
    let annonce = Annonce()
    
    
    
    // image picker
    let firstImagePicker = UIImagePickerController()
    let secondImagePicker = UIImagePickerController()
    let thirdImagePicker = UIImagePickerController()
    let fourthImagePicker = UIImagePickerController()
    

    
    
    // buttons
    @IBOutlet weak var vueDeFaceButton: UIButton!
    @IBOutlet weak var vueDarriereButton: UIButton!
    @IBOutlet weak var vueDeGaucheButton: UIButton!
    @IBOutlet weak var vueDeDroiteButton: UIButton!
    @IBOutlet weak var terminerButton: UIButton!
    @IBOutlet weak var mesAnnonceButton: UIButton!
    @IBOutlet weak var switcher: UILabel!
    
    
    
    @IBAction func reloadData(_ sender: UIButton) {
        
        self.reloadeData()
        
        
    }
    
    
    @IBAction func carburantSwitcher(_ sender: Any) {
        switcher.text = carburantSegmentControl.titleForSegment(at: carburantSegmentControl.selectedSegmentIndex)
    }
    
    
    
    // button actions
    @IBAction func setVueDeFaceAction(_ sender: UIButton) {
        
        
        UIApplication.shared.statusBarStyle = .default
        firstImagePicker.allowsEditing = false
        firstImagePicker.sourceType = .photoLibrary
        self.show(firstImagePicker, sender: nil)

    }
    
    @IBAction func setVueDarriereAction(_ sender: UIButton) {
        UIApplication.shared.statusBarStyle = .default
        secondImagePicker.allowsEditing = false
        secondImagePicker.sourceType = .photoLibrary
        self.show(secondImagePicker, sender: nil)
    }
    
    
   
    @IBAction func setVueDeGaucheAction(_ sender: UIButton) {
        UIApplication.shared.statusBarStyle = .default
        thirdImagePicker.allowsEditing = false
        thirdImagePicker.sourceType = .photoLibrary
        self.show(thirdImagePicker, sender: nil)
    }
    
    
    @IBAction func setVueDeDroiteAction(_ sender: UIButton) {
        UIApplication.shared.statusBarStyle = .default
        fourthImagePicker.allowsEditing = false
        fourthImagePicker.sourceType = .photoLibrary
        self.show(fourthImagePicker, sender: nil)
    }

    
    // MARK - END
    
    
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            if picker == firstImagePicker {
                vueDeFaceButton.setImage(pickedImage, for: .normal)
            }
            if picker == secondImagePicker {
                vueDarriereButton.setImage(pickedImage, for: .normal)
            }
            if picker == thirdImagePicker {
                vueDeGaucheButton.setImage(pickedImage, for: .normal)
            }
            if picker == fourthImagePicker {
                vueDeDroiteButton.setImage(pickedImage, for: .normal)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    

    
    static var selectedYearValue = MakeYears()
    static var selectedMarqueValue = SharedMakes()
    static var selectedModelValue = SharedModel()
    
    
    let datePicker = SCPopDatePicker()
    let date = Date()
    
    
    var didSetCustomData = false
    
    @IBOutlet weak var autreButton: UIButton!

    
    // - Labels
    @IBOutlet weak var selectedYear: UILabel!
    @IBOutlet weak var selectedMarque: UILabel!
    @IBOutlet weak var selectedModel: UILabel!
    @IBOutlet weak var dateDeMiseEnCirculation: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    // - Views
    
    @IBOutlet weak var selectYearView: UIView!
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var selectModelView: UIView!
    @IBOutlet weak var selectBrandView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var categoryView: UIView!
    
    
    // text field
    @IBOutlet weak var autreOptionTextView: UITextView!
    @IBOutlet weak var nombrePorteTextField: UITextField!
    @IBOutlet weak var kilometrageTextField: UITextField!
    @IBOutlet weak var prixTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var puisscanceFiscalText: UITextField!
    
    
    // segment control
    @IBOutlet weak var etatSegmentControl: UISegmentedControl!
    @IBOutlet weak var carburantSegmentControl: UISegmentedControl!
    @IBOutlet weak var transimissionSegmentControl: UISegmentedControl!
    
    
    func generateUniqueFileName() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        let fileName = "\(components.year!)\(components.month!)\(components.day!)\(components.hour!)\(components.minute!)\(components.second!)\(components.nanosecond!)"
        return fileName
    }
    
    
    
    func validateData () -> Bool{
        
        if ( selectedYear.text != "--" && selectedMarque.text != "--" && selectedModel.text != "--" && puisscanceFiscalText.text != "" && dateDeMiseEnCirculation.text != "DATE DE MISE EN CIRCULATION" && telephoneTextField.text != "" && prixTextField.text != "" && kilometrageTextField.text != "" && nombrePorteTextField.text != "" && autreOptionTextView.text != "Içi vous pouvez decrire votre vehicule... et toute autres options " && categoryLabel.text != "--")  {
            
            
            return true
            
        }
        
        else{
            
            return false
        }
        
        
    }
    
    func reloadeData(){
        selectedYear.text = "--"
        selectedMarque.text = "--"
        selectedModel.text = "--"
        transimissionSegmentControl.selectedSegmentIndex = 0
        carburantSegmentControl.selectedSegmentIndex = 0
        etatSegmentControl.selectedSegmentIndex = 0
        dateDeMiseEnCirculation.text = "DATE DE MISE EN CIRCULATION"
        categoryLabel.text = "--"
        telephoneTextField.text = ""
        prixTextField.text = ""
        kilometrageTextField.text = ""
        nombrePorteTextField.text = ""
        self.puisscanceFiscalText.text = ""
        vueDeFaceButton.setImage(UIImage(named:"front-side"), for: .normal)
        vueDeDroiteButton.setImage(UIImage(named:"right-side"), for: .normal)
        vueDeGaucheButton.setImage(UIImage(named:"left-side"), for: .normal)
        vueDarriereButton.setImage(UIImage(named:"back-side-1"), for: .normal)

        setupTextView()
        
        
        
    }
    
    

    
    @IBAction func terminerButtonAction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            if self.validateData(){
                
                let date = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
                
                
                
                annonce.type = categoryLabel.text!
                annonce.brand_id = SellYourCarViewController.selectedMarqueValue.id
                annonce.model = SellYourCarViewController.selectedMarqueValue.name + " " + selectedModel.text!
                annonce.annee = selectedYear.text!
                annonce.transmissiom = transimissionSegmentControl.titleForSegment(at: transimissionSegmentControl.selectedSegmentIndex)!
                annonce.puissance_fiscal = puisscanceFiscalText.text!
                annonce.kilometrage = kilometrageTextField.text!
                annonce.couleur = "NOIR"
                annonce.nombrePorte = nombrePorteTextField.text!
                annonce.carburant = carburantSegmentControl.titleForSegment(at: carburantSegmentControl.selectedSegmentIndex)!
                annonce.date_mise_circulation = dateDeMiseEnCirculation.text!
                annonce.prix = prixTextField.text!
                annonce.num_tel = telephoneTextField.text!
                annonce.etat = etatSegmentControl.titleForSegment(at: etatSegmentControl.selectedSegmentIndex)!
                annonce.category = categoryLabel.text!
                annonce.autreDescription = autreOptionTextView.text!
                annonce.date_publication = "\(components.day!)-\(components.month!)-\(components.year!)"
                if FIRAuth.auth()?.currentUser != nil {
                    annonce.user_id = (FIRAuth.auth()?.currentUser?.uid)!
                }
                
                
                   
                
                DispatchQueue.global(qos: .background).async {
                    KRProgressHUD.show(message: "Veuillez Patienter")
                    Annonce.insertUserAnnonce(annonce: self.annonce)

                    DispatchQueue.main.async {
                        let annonce_id = Annonce.getLastAnnonceId(userId: (FIRAuth.auth()?.currentUser?.uid)!)
                        let annoncesImages = [self.vueDeFaceButton.imageView?.image, self.vueDarriereButton.imageView?.image, self.vueDeGaucheButton.imageView?.image, self.vueDeDroiteButton.imageView?.image]
                        let metaData = FIRStorageMetadata()
                        metaData.contentType = "image/jpg"
                        
                        
                        
                        let firstFileName = self.generateUniqueFileName()
                        let firstStorageRef = FIRStorage.storage().reference().child("annonces_photos").child(firstFileName)
                        if let firstImage = UIImageJPEGRepresentation((annoncesImages[0])!, 80){
                            firstStorageRef.put(firstImage, metadata: metaData, completion: { (metadata, error) in
                                
                                if error != nil {
                                    print(error ?? "")
                                    return
                                    
                                }
                                let annoncePhoto = AnnoncePhoto()
                                annoncePhoto.annonce_id = annonce_id
                                annoncePhoto.file_name = firstFileName
                                _ = AnnoncePhoto.insertPhotoAnnonce(annoncePhoto: annoncePhoto)
                                print(metadata ?? " there is no metadata ")
                                
                            })
                        }
                        
                        
                        
                        
                        let secondFileName = self.generateUniqueFileName()
                        let secondStorageRef = FIRStorage.storage().reference().child("annonces_photos").child(secondFileName)
                        if let secondImage = UIImageJPEGRepresentation((annoncesImages[1])!, 80){
                            secondStorageRef.put(secondImage, metadata: metaData, completion: { (metadata, error) in
                                
                                if error != nil {
                                    print(error ?? "")
                                    return
                                }
                                let annoncePhoto = AnnoncePhoto()
                                annoncePhoto.annonce_id = annonce_id
                                annoncePhoto.file_name = secondFileName
                                _ = AnnoncePhoto.insertPhotoAnnonce(annoncePhoto: annoncePhoto)
                                print(metadata ?? " there is no metadata ")
                            })
                        }
                        
                        
                        let thirdFileName = self.generateUniqueFileName()
                        let thirdStorageRef = FIRStorage.storage().reference().child("annonces_photos").child(thirdFileName)
                        if let thirdImage = UIImageJPEGRepresentation((annoncesImages[2])!, 80){
                            thirdStorageRef.put(thirdImage, metadata: metaData, completion: { (metadata, error) in
                                
                                if error != nil {
                                    print(error ?? "")
                                    return
                                }
                                let annoncePhoto = AnnoncePhoto()
                                annoncePhoto.annonce_id = annonce_id
                                annoncePhoto.file_name = thirdFileName
                                _ = AnnoncePhoto.insertPhotoAnnonce(annoncePhoto: annoncePhoto)
                                print(metadata ?? " there is no metadata ")
                            })
                        }
                        
                        
                        let fourthFileName = self.generateUniqueFileName()
                        let fourthStorageRef = FIRStorage.storage().reference().child("annonces_photos").child(fourthFileName)
                        if let fourthImage = UIImageJPEGRepresentation((annoncesImages[3])!, 80){
                            fourthStorageRef.put(fourthImage, metadata: metaData, completion: { (metadata, error) in
                                
                                if error != nil {
                                    print(error ?? "")
                                    return
                                }
                                let annoncePhoto = AnnoncePhoto()
                                annoncePhoto.annonce_id = annonce_id
                                annoncePhoto.file_name = fourthFileName
                                _ = AnnoncePhoto.insertPhotoAnnonce(annoncePhoto: annoncePhoto)
                                print(metadata ?? " there is no metadata ")
                                KRProgressHUD.dismiss({
                                    self.tabBarController?.selectedIndex = 3
                                    self.reloadeData()
                                })
                            })
                        }

                     
                    }
                }
                
                
                
                
            }
            else{
                let alert = SCLAlertView()
            KRProgressHUD.dismiss({ 
                    alert.showError("Erreur", subTitle: "Veuillez remplir tous les champs", closeButtonTitle: "Repeter", duration: .infinity, colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .bottomToTop)
            })
            }
        }else{

            KRProgressHUD.dismiss({ 
                CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()

            })
            
        }
    }
    
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        if SellYourCarViewController.selectedYearValue.year != "" {
            selectedYear.text = SellYourCarViewController.selectedYearValue.year
            selectedYear.textColor = UIColor.black

        }
        
        
        if SellYourCarViewController.selectedMarqueValue.name != "" {
            selectedMarque.text = SellYourCarViewController.selectedMarqueValue.name
            selectedMarque.textColor = UIColor.black


        }
        if SellYourCarViewController.selectedModelValue.name != "" {
            selectedModel.text = SellYourCarViewController.selectedModelValue.name
            selectedModel.textColor = UIColor.black
            
            
        }
        
    }
    
    func dismissKeyboard() {
        nombrePorteTextField.resignFirstResponder()
        kilometrageTextField.resignFirstResponder()
        prixTextField.resignFirstResponder()
        telephoneTextField.resignFirstResponder()
        puisscanceFiscalText.resignFirstResponder()
        autreOptionTextView.resignFirstResponder()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nombrePorteTextField.resignFirstResponder()
        kilometrageTextField.resignFirstResponder()
        prixTextField.resignFirstResponder()
        telephoneTextField.resignFirstResponder()
        puisscanceFiscalText.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstImagePicker.delegate = self
        secondImagePicker.delegate = self
        thirdImagePicker.delegate = self
        fourthImagePicker.delegate = self
        autreOptionTextView.delegate = self
        
        
        setupNavigationBar()
        setupGestures()
        setupTextView()
        

        
       nombrePorteTextField.delegate = self
       kilometrageTextField.delegate = self
       prixTextField.delegate = self
       telephoneTextField.delegate = self
       puisscanceFiscalText.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SellYourCarViewController.dismissKeyboard)))


        autreButton.isHidden = true
        autreButton.layer.borderWidth = 0.5
        autreButton.layer.borderColor = UIColor.red.cgColor
        autreButton.layer.cornerRadius = 5
        autreButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        autreButton.layer.shadowOpacity = 0.3
        
        
        terminerButton.layer.borderWidth = 0.5
        terminerButton.layer.borderColor = UIColor.red.cgColor
        terminerButton.layer.cornerRadius = 5
        terminerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        terminerButton.layer.shadowOpacity = 0.3
        

    }
    
    
    
   
    
    func setupTextView(){
        
        autreOptionTextView.delegate = self
        
        autreOptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        autreOptionTextView.layer.borderWidth = 1.0
        autreOptionTextView.layer.cornerRadius = 5
        
        autreOptionTextView.text = "Içi vous pouvez decrire votre vehicule... et toute autres options "
        autreOptionTextView.textColor = UIColor.lightGray
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if autreOptionTextView.textColor == UIColor.lightGray {
            autreOptionTextView.text = nil
            autreOptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if autreOptionTextView.text.isEmpty {
           autreOptionTextView.text = "Içi vous pouvez decrire votre vehicule... et toute autres options "
            autreOptionTextView.textColor = UIColor.lightGray
        }
    }
    
    func setupGestures(){
        
        let yearTap = UITapGestureRecognizer(target: self, action: #selector(handleYearTap))
        selectYearView.addGestureRecognizer(yearTap)
        
        let marqueTap = UITapGestureRecognizer(target: self, action: #selector(handleMarqueTap))
        selectBrandView.addGestureRecognizer(marqueTap)
        
        let modelTap = UITapGestureRecognizer(target: self, action: #selector(handleModelTap))
        selectModelView.addGestureRecognizer(modelTap)
        
        let dateTap = UITapGestureRecognizer(target: self, action: #selector(handleDateTap))
        datePickerView.addGestureRecognizer(dateTap)
        
        let categoryTap = UITapGestureRecognizer(target: self, action: #selector(handleCategoryTap))
        categoryView.addGestureRecognizer(categoryTap)
        
    }
    
    
    @IBAction func autreAction(_ sender: UIButton) {
        
        let alert = SCLAlertView()
        let annee = alert.addTextField("Année")
        let marque = alert.addTextField("Marque")
        let model = alert.addTextField("Model")
        
        
        
        alert.addButton("Confirmer") {
            if annee.text != "" && marque.text != "" && model.text != ""{
                
                self.selectedYear.text = annee.text
                self.selectedMarque.text = marque.text
                self.selectedModel.text = model.text
                
                self.selectedYear.textColor = UIColor.black
                self.selectedMarque.textColor = UIColor.black
                self.selectedModel.textColor = UIColor.black
                self.didSetCustomData = true
                
                
            }else{
                
                KRProgressHUD.showError()
            }
            
        }
        alert.showEdit("Information Générale", subTitle: "", closeButtonTitle: "Annuler", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
        
    }
    
    
    
    private func setupNavigationBar(){
        
        let myRedColor = UIColor(red: 234/255.0, green: 68/255.0, blue: 63/255.0, alpha: 1)
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = false
        let myGreyColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        self.navigationController!.navigationBar.tintColor = myRedColor
        navigationController!.navigationBar.barTintColor = myGreyColor
        
    }
    

    func handleDateTap(sender: UITapGestureRecognizer? = nil) {
     
        if Reachability.isConnectedToNetwork() {
            self.datePicker.tapToDismiss = true
            self.datePicker.datePickerType = SCDatePickerType.date
            self.datePicker.showBlur = true
            self.datePicker.datePickerStartDate = self.date
            self.datePicker.btnFontColour = UIColor.white
            self.datePicker.btnColour = UIColor(hexString: "#f0413aFF")!
            self.datePicker.showCornerRadius = false
            self.datePicker.delegate = self
            self.datePicker.show(attachToView: self.view)
        }else{
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
    }
    
    
    
    func handleCategoryTap(sender: UITapGestureRecognizer? = nil) {
        
        if Reachability.isConnectedToNetwork() {
            // Prepare the popup assets
            let title = "VEUILLEZ CHOISIR UNE CATEGORY"
            let message = ""
            let image = UIImage(named: "")
            
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)
            
            // Create first button
            let retour = CancelButton(title: "RETOUR") {
                
            }
            
            // Create second button
            let convertible = DefaultButton(title: "CONVERTIBLE") {
                self.categoryLabel.text = "CONVERTIBLE"
            }
            
            // Create third button
            let coupe = DefaultButton(title: "COUPE") {
                self.categoryLabel.text = "COUPE"
            }
            let hatchback = DefaultButton(title: "HATCHBACK") {
                self.categoryLabel.text = "HATCHBACK"
                
            }
            let miniVan = DefaultButton(title: "MINI VAN") {
                self.categoryLabel.text = "MINI VAN"
            }
            let sedan = DefaultButton(title: "SEDAN") {
                self.categoryLabel.text = "SEDAN"
            }
            let suv = DefaultButton(title: "SUV") {
                self.categoryLabel.text = "SUV"
            }
            let truck = DefaultButton(title: "TRUCK") {
                self.categoryLabel.text = "TRUCK"
            }
            let wagon = DefaultButton(title: "WAGON") {
                self.categoryLabel.text = "WAGON"
                
            }
            
            
            retour.titleColor = UIColor.darkGray
            convertible.titleColor = UIColor.red
            coupe.titleColor = UIColor.red
            hatchback.titleColor = UIColor.red
            miniVan.titleColor = UIColor.red
            sedan.titleColor = UIColor.red
            suv.titleColor = UIColor.red
            truck.titleColor = UIColor.red
            wagon.titleColor = UIColor.red
            
            
            // Add buttons to dialog
            popup.addButtons([retour, convertible, coupe, hatchback, miniVan, sedan, suv, truck, wagon])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }else{
            CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
        }
    }
    
    
    
    
    func handleYearTap(sender: UITapGestureRecognizer? = nil) {
        if Reachability.isConnectedToNetwork() {
            selectedYear.text = "--"
            selectedMarque.text = "--"
            selectedModel.text = "--"
            
            
            
            SellYourCarViewController.selectedYearValue = MakeYears()
            SellYourCarViewController.selectedMarqueValue = SharedMakes()
            SellYourCarViewController.selectedModelValue = SharedModel()
            
            let yearsTableView = storyboard?.instantiateViewController(withIdentifier: "YearsTableViewController") as! YearsTableViewController
            present(yearsTableView, animated: true, completion: nil)
        }else{
            connectivityAlert()
        }
        
    }
    
    func connectivityAlert() {
        CDAlertView(title: "Oups", message: "Probléme de connexion !" , type: .warning).show()
    }
    
    func handleMarqueTap(sender: UITapGestureRecognizer? = nil) {
        
        
        if Reachability.isConnectedToNetwork() {
            if selectedYear.text != "--" && didSetCustomData == false {
                selectedMarque.text = "--"
                selectedModel.text = "--"
                
                
                SellYourCarViewController.selectedMarqueValue = SharedMakes()
                SellYourCarViewController.selectedModelValue = SharedModel()
                
                let sharedTableView = storyboard?.instantiateViewController(withIdentifier: "SharedMakesViewController") as! SharedMakesViewController
                sharedTableView.year = selectedYear.text!
                self.navigationController?.present(sharedTableView, animated: true, completion: nil)
            }else{
                
                SCLAlertView().showError("Oups", subTitle: "Veuillez respecter l'ordre", closeButtonTitle: "Fermer", duration: .infinity, colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .topToBottom)
                
                if self.didSetCustomData == true {
                    selectedYear.text = "--"
                    selectedMarque.text = "--"
                    selectedModel.text = "--"
                    
                }
            }
        }else{
            connectivityAlert()
        }
        
    }
    
    
    
    
    
    func handleModelTap(sender: UITapGestureRecognizer? = nil) {
        
        

        if Reachability.isConnectedToNetwork() {
            if selectedMarque.text != "--" && didSetCustomData == false {
                
                selectedModel.text = "--"
                SellYourCarViewController.selectedModelValue = SharedModel()
                let sharedModelsTableView = storyboard?.instantiateViewController(withIdentifier: "SharedModelsViewController") as! SharedModelsViewController
                sharedModelsTableView.make_id = SellYourCarViewController.selectedMarqueValue.id
                sharedModelsTableView.year = SellYourCarViewController.selectedYearValue.year
                self.navigationController?.present(sharedModelsTableView, animated: true, completion: nil)
            }else{
                SCLAlertView().showError("Oups", subTitle: "Veuillez respecter l'ordre", closeButtonTitle: "Fermer", duration: .infinity, colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .topToBottom)
                
                if self.didSetCustomData == true {
                    selectedYear.text = "--"
                    selectedMarque.text = "--"
                    selectedModel.text = "--"
                    self.didSetCustomData = false
                    
                }
                
            }

        }else{
            connectivityAlert()
        }
    }
    
    
   
    func scPopDatePickerDidSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        dateDeMiseEnCirculation.text = dateString
        
    }

    
    
}


extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}


extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
}









