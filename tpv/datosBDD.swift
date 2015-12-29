//
//  datosBDD.swift
//  tpv
//
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.
//
import Alamofire

import Foundation

protocol datosBDD {
    /* Devuelve json con el resultado
        {electrica = {control = 0; libre = "hh:mm:ss", nombre = "electrica 1"}
         whaly = {}
         gold = {}
         rio = {}
        }*/
    func primeraLibre(_: [String : AnyObject])
    }




class webServiceCallAPI: NSObject {
    var delegate : datosBDD?
    
    func primeraLibre() {
        Alamofire.request(.GET, "https://losbarkitos.herokuapp.com/primera_libre/")
            .responseJSON { response in
                /*print("response.request: \(response.request)")
                print("response.response: \(response.response)")
                print("response.data: \(response.data)")
                print("response.error: \(response.result)")
                print("response.result.value: \(response.result.value)")*/
            
                if let diccionario = response.result.value {
                    self.delegate?.primeraLibre(diccionario as! [String : AnyObject])
                }
            }
    }
}