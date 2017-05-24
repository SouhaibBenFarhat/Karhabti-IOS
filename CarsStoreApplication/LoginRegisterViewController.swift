//
//  ViewController.swift
//  CarsStoreApplication
//
//  Created by mac on 30/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SCLAlertView
import CDAlertView
import KRProgressHUD




class LoginRegisterViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, UITextFieldDelegate {


    @IBOutlet weak var quiSommeNousButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var LoginRegisterContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingProcessIndicator: UIActivityIndicatorView!
    @IBOutlet weak var rememberMeSwitch: UISwitch!

    @IBOutlet weak var customizedFacebookButton: UIButton!
    @IBOutlet weak var customizedGoogleButton: UIButton!
    @IBOutlet weak var loginSegmentSelector: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    @IBAction func aboutAction(_ sender: UIButton) {
        let aboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.present(aboutViewController, animated: true) {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    @IBAction func loginRegisterSelectorEvent(_ sender: UISegmentedControl) {
        let selectedIndex = loginSegmentSelector.selectedSegmentIndex
        if selectedIndex == 1 {
            let alert = SCLAlertView()
            let username = alert.addTextField("Adresse email")
            let password = alert.addTextField("Mot de passe")
            password.isSecureTextEntry = true
            let confirmPassword = alert.addTextField("Confirmation de mot de pass")
            confirmPassword.isSecureTextEntry = true
            
            alert.addButton("Confirmer") {
                if (username.text != "" && password.text != "" && confirmPassword.text != ""){
                    if ( password.text == confirmPassword.text ){
                        KRProgressHUD.show()
                        self.handleRegister(email: username.text!, password: password.text!)
                    }else{
                         SCLAlertView().showError("Echec", subTitle: "Merci de verifier votre mot de passe") // Error
                        self.loginSegmentSelector.selectedSegmentIndex = 0
                    }
                }
                
            }
            alert.showEdit("Inscription", subTitle: "Inscrivez-vous", closeButtonTitle: "Annuler", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
        }
    }
    
    
    
    func handleRegister( email: String, password: String){

        
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                self.showError()
                return
            }
        
                KRProgressHUD.dismiss({
                    self.emailTextField.text = email
                    self.passwordTextField.text = password
                    
                    if self.rememberMeSwitch.isOn {
                        
               
                        self.defaults.set(email, forKey: "email")
                        self.defaults.set(password, forKey: "password")
                    }
                    self.showAlert()
                })
        })
        
    }
    
    
    func showAlert(){
        
        SCLAlertView().showSuccess("Inscription", subTitle: "Inscription effectué avec succès.")
        print("authentifcated")
        self.loginSegmentSelector.selectedSegmentIndex = 0
      
    }
    
    func showError(){
        KRProgressHUD.dismiss({SCLAlertView().showError("Echec", subTitle: "Merci de vérifier vos données")
            })
    }
    
    
    func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    func reNew(){
        //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "LoginRegisterNavigationController")
    }
    
    func reachabilityAlert() {
        let alert = SCLAlertView()
        alert.addButton("OK") {
            self.reNew()
        }
        alert.showError("Oups", subTitle: "Une connexion internet est requise", closeButtonTitle: "RETOUR", colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Reachability.isConnectedToNetwork() == false {
    
            reachabilityAlert()
            
        }
    
        
        
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginRegisterViewController.dismissKeyboard)))
        
//        if FIRAuth.auth()?.currentUser != nil {
//            
//            KRProgressHUD.show(message: "Chargememt...")
//            let pushMe = MainTabBar()
//            self.show(pushMe, sender: nil)
//             KRProgressHUD.dismiss()
//        }
        
        
        passwordTextField.isSecureTextEntry = true
        loadingProcessIndicator.isHidden = true
        if defaults.string(forKey: "email") != nil && defaults.string(forKey: "password") != nil
        {
            
            emailTextField.text = defaults.string(forKey: "email")
            passwordTextField.text = defaults.string(forKey: "password")
        }

        //customize login button
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
        
        quiSommeNousButton.layer.cornerRadius = 5
        quiSommeNousButton.layer.borderWidth = 0
        quiSommeNousButton.layer.borderColor = UIColor.white.cgColor
        quiSommeNousButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        
        LoginRegisterContainerView.layer.borderWidth = 0.5
        LoginRegisterContainerView.layer.borderColor = UIColor.red.cgColor
        LoginRegisterContainerView.layer.cornerRadius = 5

        
        //customize google plus button 
        customizedGoogleButton.layer.cornerRadius = 5
        customizedGoogleButton.layer.borderWidth = 0
        customizedGoogleButton.layer.borderColor = UIColor.white.cgColor
        customizedGoogleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        customizedGoogleButton.layer.shadowOpacity = 0.3
        customizedGoogleButton.adjustsImageWhenHighlighted = false
        customizedGoogleButton.addTarget(self, action: #selector(handleCustoGoogleSignIn), for: .touchUpInside)
        
        //customize facebook button
        customizedFacebookButton.layer.cornerRadius = 5
        customizedFacebookButton.layer.borderWidth = 0
        customizedFacebookButton.layer.borderColor = UIColor.white.cgColor
        customizedFacebookButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        customizedFacebookButton.layer.shadowOpacity = 0.3
        customizedFacebookButton.adjustsImageWhenHighlighted = false
        customizedFacebookButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)

        
        setupFqceBookButtons()
        setupGoogleButtons()
        
        
  
    }

  
    
    
    @IBAction func connectToFirebase(_ sender: AnyObject) {
        

        loadingProcessIndicator.isHidden = false
        loadingProcessIndicator.hidesWhenStopped = true
        
        
        if Reachability.isConnectedToNetwork() == false {
            reachabilityAlert()
        }else{
            KRProgressHUD.show()
            
            let email = self.emailTextField.text
            let password = self.passwordTextField.text
            
            if email != "" && password != "" {
                self.loadingProcessIndicator.startAnimating()
                FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
                    if error == nil{
                        
                        print("successfully logged in anonymosly")
                        
                        
                        if self.rememberMeSwitch.isOn {
                            
                            self.defaults.set(email, forKey: "email")
                            self.defaults.set(password, forKey: "password")
                        }
                        
                        
                        let pushMe = MainTabBar()
                        KRProgressHUD.dismiss({
                            self.show(pushMe, sender: nil)
                            self.loadingProcessIndicator.stopAnimating()
                        })
                        
                        
                    }else{
                        print(error ?? "")
                        self.showError()
                        self.loadingProcessIndicator.stopAnimating()
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    }
                })
            }else{
                KRProgressHUD.dismiss({
                    SCLAlertView().showError("Oups", subTitle: "Merci de remplir tous les champs",colorStyle: 0xe74c3c, colorTextButton: 0xFFFFFF)
                })
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .default
        
   

        
    }
    
    
    func handleCustoGoogleSignIn(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    fileprivate func setupGoogleButtons(){
    
    
        //add google sign in buttons
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x:16, y:510 , width: view.frame.width-32, height: 30)
      //  view.addSubview(googleButton)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
    
    }
    
 
    
    fileprivate func setupFqceBookButtons(){
    
        let loginButton = FBSDKLoginButton()
       // view.addSubview(loginButton)
        loginButton.frame = CGRect(x:16, y:570, width: view.frame.width-32, height: 30)
        
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        
        let customFaceBookLoginButton = UIButton(type: .system)
        customFaceBookLoginButton.backgroundColor = .blue
        customFaceBookLoginButton.frame = CGRect(x:16, y:116, width: view.frame.width-32, height: 50)
        
    //    view.addSubview(customFaceBookLoginButton)
        customFaceBookLoginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    
    }
    @IBAction func custofbTestButton(_ sender: UIButton) {
        handleCustomFBLogin()
    }
    
    @IBAction func customgoogleTestButton(_ sender: UIButton) {
        handleCustoGoogleSignIn()
    }
    func handleCustomFBLogin(){
        
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self)
        {(result, err) in
            if err != nil {
                print("fb login failed")
                return
            }
            self.showEmailAddress()

            
        }
        
        
            }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out of facebook")
    }
 
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
        print(error)
                    return
        }
        print("successfully logged in")
        showEmailAddress()

}
    func showEmailAddress(){
        
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        let credientials =
            FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        
        KRProgressHUD.show()
        FIRAuth.auth()?.signIn(with: credientials, completion: { (user, error) in
            if error != nil{
                print("Something went wrong", error ?? " ")
                return
            }
            KRProgressHUD.dismiss({ 
               
                
                            let pushMe = MainTabBar()
                           self.show(pushMe, sender: nil)
              
            })
            print("Successfuly logged in with our user ", user ?? "")
        })
        FBSDKGraphRequest(graphPath:"/me", parameters: ["fields": "id, name, email"]).start{
            (connection, result, err) in
            if err != nil {
                print("failed to connect to facebook")
                return
            }
            
            print(result ?? "default")
        }
        
    }
    
    
}
