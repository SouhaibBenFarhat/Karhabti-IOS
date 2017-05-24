//
//  Demo1Controller.swift
//  StretchHeaderDemo
//
//  Created by yamaguchi on 2016/03/27.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import KRProgressHUD
import CDAlertView

class ModelsListViewController: MIPivotPage, UITableViewDataSource, UITableViewDelegate {

    var header : StretchHeader!
    var tableView : UITableView!
    var navigationView = UIView()
    var modelBrand = Brand()
    var models = [Model]()
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
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
        
        DispatchQueue.global(qos: .background).async {

            self.models = Model.downloadAllModels(idd : self.modelBrand.id)

            DispatchQueue.main.async {
                self.tableView.reloadData()
 
            }
        }
        
        //Mark - loading Models
        
        
        
      
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        self.tableView.rowHeight = 290.0
        tableView.register(UINib(nibName: "ModelsTableViewCell", bundle: nil), forCellReuseIdentifier: "ModelCell")
        tableView.register(UINib(nibName: "BlankTableViewCell", bundle: nil), forCellReuseIdentifier: "BlankCell")
        setupHeaderView()
        
        // NavigationHeader
        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1.0)
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 20, width: 44, height: 44)
        button.setImage(UIImage(named: "navi_back_btn")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(ModelsListViewController.leftButtonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func setupHeaderView() {
        
        let options = StretchHeaderOptions()
        options.position = .fullScreenTop
        self.view.backgroundColor = UIColor.white
        header = StretchHeader()
        header.backgroundColor = UIColor.white
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 220),
            imageSize: CGSize(width: view.frame.size.width, height: 220),
            controller: self,
            options: options)
         header.imageView.image = UIImage(named: "white-background")
        
        
        
        DispatchQueue.global(qos: .background).async {
            let photoURL = NSURL(string: self.modelBrand.cover!)
            if (photoURL != nil && self.modelBrand.cover != ""){
                let imageUrl:URL = photoURL! as URL
            DispatchQueue.main.async {
                self.header.imageView.sd_setImage(with: imageUrl)

            }
        }

            
        }
        
        
        
        // custom
        let label = UILabel()
        label.frame = CGRect(x: 10, y: header.frame.size.height - 40, width: header.frame.size.width - 20, height: 40)
        label.textColor = UIColor.white
        label.text = modelBrand.name
        label.font = UIFont.boldSystemFont(ofSize: 16)
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    
    // MARK: - Selector
    func leftButtonAction() {
        self.navigationController!.popViewController(animated: true)
         self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.updateScrollViewOffset(scrollView)
      
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
             return models.count
        }else{
            return 1
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell", for: indexPath) as! ModelsTableViewCell
            cell.newObject = models[indexPath.row]
            cell.modelImage.sd_setImage(with: models[indexPath.row].picture_url)
            cell.setNeedsLayout() //invalidate current layout
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankCell", for: indexPath) as! BlankTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KRProgressHUD.show()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let modelDetail = storyboard.instantiateViewController(withIdentifier :"GammeListViewController") as! GammeListViewController
        DispatchQueue.global(qos: .background).async {
            modelDetail.modelPhotos = ModelPhoto.downloadAllPhotos(idd: self.models[indexPath.row].id)
            modelDetail.gammes = Gamme.downloadAllGammes(idd: self.models[indexPath.row].id)
            modelDetail.model = self.models[indexPath.row]
            DispatchQueue.main.async {
                if Reachability.isConnectedToNetwork(){
                    if modelDetail.gammes.count > 0{
                        KRProgressHUD.dismiss({
                            self.navigationController?.pushViewController(modelDetail, animated: true)
                        })
                    }else{
                       KRProgressHUD.dismiss({ 
                         CDAlertView(title: "Bientôt !", message: "Aucune gamme disponible pour le model" + self.models[indexPath.row].name, type: .notification).show()
                       })
                    }
                }else{
                        KRProgressHUD.dismiss({ 
                            CDAlertView(title: "Oups", message: "Probléme de connexion !", type: .warning).show()
                        })
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 66
        }else{
            return 290
        }
    }
}
