//
//  ViewController.swift
//  tpv
//
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.

import Cocoa

class ViewController: NSViewController, datosBDD {

    var webService : webServiceCallAPI = webServiceCallAPI()
    
    
    @IBAction func boton(sender: NSButtonCell) {
        webService.MFinsertar_ticket(400)
    }
    
    @IBAction func recuperar(sender: NSButtonCell) {
        webService.MFrecuperar_ticket(14)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService.delegate = self
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//  METODOS DELEGADOS DE datosBDD
    func ticketInsertado(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 {
                 print("ERROR EN EL SERVIDOR")
            } else if k as String == "error" && v as! Int == 0 {
                print("REGISTRO INSERTADO CORRECTAMENTE")
            }
        }
        
    }
    
    func ticketRecuperado(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "numero" {
                print("REGISTRO \(v as! String) RECUPERADO CORRECTAMENTE")
            }
        }
    }
}

