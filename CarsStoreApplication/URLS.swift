//
//  URLS.swift
//  CarsStoreApplication
//
//  Created by mac on 21/12/2016.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class URLS{
  
    
    static var ADD_USER_FAVORIS = ""
    static var DID_FAVORIS_EXIST = ""
    static var DOWNLOAD_RAFFINEMET = ""
    static var DOWNLOAD_CARACTERISTIQUE = ""
    static var DOWNLOAD_MOTORISATION = ""
    static var DOWNLOAD_ALL_GAMME_PHOTO = ""
    static var DOWNLOAD_ALL_MODEL_PHOTO = ""
    static var GET_ALL_GAMME = ""
    static var GET_GAMME_BY_ID = ""
    static var GET_GAMME_FAVORIS = ""
    static var GET_MODELS = ""
    static var GET_CONCESSIONNAIRES = ""
    static var GET_BRANDS = ""
    static var GET_ARTICLES = ""
    static var POST_METHOD = ""
    static var GET_MAKE_YEARS = ""
    static var GET_SHARED_MAKES = ""
    static var GET_SHARED_MODELS = ""
    static var GET_BODY_TYPE = ""
    static var GET_ANNONCES = ""
    static var GET_BRAND_LOGO = ""
    static var INSERT_ANNONCE = ""
    static var GET_LAST_ANNONCE_ID = ""
    static var INSERT_ANNONCE_PHOTO = ""
    static var GET_ANNONCE_THUMBNAIL = ""
    static var GET_ANNONCE_PHOTO = ""
    static var DELETE_USER_FAVORIS = ""
    static var GET_ANNONCE_BY_USER = ""
    static var DELETE_ANNONCE = ""
    static var FIND_ANNONCE_BY_MODELE = ""
    static var PING = ""
    
    
    
    
    
    
    static func toTheServer(){
    
    
     ADD_USER_FAVORIS = "http://inceptumapps.com/carsstore/mobile/ios/insert_into_favoris.php"
     DID_FAVORIS_EXIST = "http://inceptumapps.com/carsstore/mobile/ios/did_favoris_exist.php?"
     DOWNLOAD_RAFFINEMET = "http://inceptumapps.com/carsstore/mobile/ios/get_gamme_raffinement.php?raffinement_id="
     DOWNLOAD_CARACTERISTIQUE = "http://inceptumapps.com/carsstore/mobile/ios/get_gamme_caracteristique.php?caracteristique_id="
     DOWNLOAD_MOTORISATION = "http://inceptumapps.com/carsstore/mobile/ios/get_gamme_motorisation.php?motorisation_id="
     DOWNLOAD_ALL_GAMME_PHOTO = "http://inceptumapps.com/carsstore/mobile/ios/get_photo_by_gamme.php?gamme_id="
     DOWNLOAD_ALL_MODEL_PHOTO = "http://inceptumapps.com/carsstore/mobile/ios/get_photo_by_model.php?model_id="
     GET_ALL_GAMME = "http://inceptumapps.com/carsstore/mobile/ios/get_gamme_by_model.php?model_id="
     GET_GAMME_BY_ID = "http://inceptumapps.com/carsstore/mobile/ios/get_gamme_by_id.php?gamme_id="
     GET_GAMME_FAVORIS = "http://inceptumapps.com/carsstore/mobile/ios/get_user_favoris.php?user_id="
     GET_MODELS = "http://inceptumapps.com/carsstore/mobile/ios/get_models_by_brand.php?brand_id="
     GET_CONCESSIONNAIRES = "http://inceptumapps.com/carsstore/mobile/ios/get_concessionnaire.php"
     GET_BRANDS = "http://inceptumapps.com/carsstore/mobile/ios/get_brands.php"
     GET_ARTICLES = "http://inceptumapps.com/carsstore/mobile/ios/xml_to_json(Magasine).php"
     GET_MAKE_YEARS = "http://inceptumapps.com/carsstore/mobile/shared/get_make_years.php"
     GET_SHARED_MAKES = "http://inceptumapps.com/carsstore/mobile/shared/get_makes_by_year.php?make_year="
     GET_SHARED_MODELS = "http://inceptumapps.com/carsstore/mobile/shared/get_models_by_make_and_make_years.php?"
     GET_BODY_TYPE = "http://inceptumapps.com/carsstore/mobile/ios/get_body_cars.php"
     GET_ANNONCES = "http://www.inceptumapps.com/carsstore/mobile/ios/get_user_annonce.php"
     GET_BRAND_LOGO = "http://www.inceptumapps.com/carsstore/mobile/ios/get_brand_logo.php?brand_id="
     INSERT_ANNONCE = "http://www.inceptumapps.com/carsstore/mobile/ios/insert_user_annonce.php"
     GET_LAST_ANNONCE_ID = "http://www.inceptumapps.com/carsstore/mobile/ios/get_last_user_annonce_id.php?user_id="
     INSERT_ANNONCE_PHOTO = "http://www.inceptumapps.com/carsstore/mobile/ios/insert_user_annonce_photo.php"
     GET_ANNONCE_THUMBNAIL = "http://www.inceptumapps.com/carsstore/mobile/ios/get_annonce_thumbnail.php?annonce_id="
     GET_ANNONCE_PHOTO = "http://inceptumapps.com/carsstore/mobile/ios/get_user_annonce_photos.php?annonce_id="
     DELETE_USER_FAVORIS = "http://inceptumapps.com/carsstore/mobile/ios/delete_user_favoris.php"
     GET_ANNONCE_BY_USER = "http://inceptumapps.com/carsstore/mobile/ios/get_mes_annonce.php?user_id="
     DELETE_ANNONCE = "http://inceptumapps.com/carsstore/mobile/ios/delete_user_annonce.php"
     FIND_ANNONCE_BY_MODELE = "http://inceptumapps.com/carsstore/mobile/ios/find_annonce_by_model.php?model_name="
     POST_METHOD = "POST"
     PING = "http://inceptumapps.com/carsstore/mobile/shared/ping.php"

        
        
    }
    
    static func toTheLocalServer(){
        
        
        ADD_USER_FAVORIS = "http://localhost/cars_store/insert_into_favoris.php"
        DID_FAVORIS_EXIST = "http://localhost/cars_store/did_favoris_exist.php?"
        DOWNLOAD_RAFFINEMET = "http://localhost/cars_store/get_gamme_raffinement.php?raffinement_id="
        DOWNLOAD_CARACTERISTIQUE = "http://localhost/cars_store/get_gamme_caracteristique.php?caracteristique_id="
        DOWNLOAD_MOTORISATION = "http://localhost/cars_store/get_gamme_motorisation.php?motorisation_id="
        DOWNLOAD_ALL_GAMME_PHOTO = "http://localhost/cars_store/get_photo_by_gamme.php?gamme_id="
        DOWNLOAD_ALL_MODEL_PHOTO = "http://localhost/cars_store/get_photo_by_model.php?model_id="
        GET_ALL_GAMME = "http://localhost/cars_store/get_gamme_by_model.php?model_id="
        GET_GAMME_BY_ID = "http://localhost/cars_store/get_gamme_by_id.php?gamme_id="
        GET_GAMME_FAVORIS = "http://localhost/cars_store/get_user_favoris.php?user_id="
        GET_MODELS = "http://localhost/cars_store/get_models_by_brand.php?brand_id="
        GET_CONCESSIONNAIRES = "http://localhost/cars_store/get_concessionnaire.php"
        GET_BRANDS = "http://localhost/cars_store/get_brands.php"
        GET_ARTICLES = "http://localhost/cars_store/xml_to_json(Magasine).php"
        POST_METHOD = "POST"
        
        
    }
    
    
    
}
