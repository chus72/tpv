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
    // Devuelve json con las barcas disponibles
    func barcas(respuesta : [String : AnyObject])
    
}

class webServiceCallAPI: NSObject {
    var delegate : datosBDD?
    
    func obtenerBarcas() {
        Alamofire.request(.GET, "https://httpbin.org/get")
            .responseJSON { response in
                print(response.request)
                print(response.response)
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
}