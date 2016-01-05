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
/*        let precio : Int = 400
        let url : String = "https://losbarkitos.herokuapp.com/MFinsertar_ticket/" + String(precio)
        webService.MFrequestBDD(url)
*/
    }
    
    @IBAction func recuperar(sender: NSButtonCell) {
        webService.MFrecuperar_ticket(14)
/*        let numero : Int = 14
        let url : String = "https://losbarkitos.herokuapp.com/MFrecuperar_ticket/" + String(numero)
        webService.MFrequestBDD(url)
*/
    }
    @IBAction func borrar(sender: NSButton) {
        webService.MFborrar_ticket(14)
    }
    
    @IBAction func eurosPush(sender: NSButton) {
        webService.MFeuros(1, mesI: 1, anyoI: 15, diaF: 31, mesF: 12, anyoF: 15)
    }
    @IBAction func mediaPush(sender: NSButton) {
        webService.MFmedia(1, mesI: 1, anyoI: 15, diaF: 31, mesF: 12, anyoF: 15)
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
    
    func ticketBorrado(respuesta: [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "numero" {
                print("REGISTRO \(v as! String) BORRADO CORRECTAMENTE")
            }
        }
    }

    func euros(respuesta : [String : Int]) {
        print("respuesta del servidor : total = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "total" {
                print("Total Euros : " + String(v))
            }
        }

    }
    
    
    func media(respuesta : [String : Float]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Media : " + String(v))
            }
        }
    }

/*    func respuesta(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
    }
*/
}

