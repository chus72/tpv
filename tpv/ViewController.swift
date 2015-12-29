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
        webService.primeraLibre()
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
    
    func primeraLibre(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
    }

}

