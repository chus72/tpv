//
//  MFViewController.swift
//  tpv
//
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.

import Cocoa

public var tickets : [Ticket] = []
public var numeroTic : Int = 0

class MFViewController: NSViewController, datosBDD, NSTableViewDataSource, NSTableViewDelegate {
    
    var webService : webServiceCallAPI = webServiceCallAPI()
    //var listadoTickets = [[String : AnyObject]]?()
    var listadoTickets = [[String : AnyObject]]()
    var diaHoy = (dia : 1, mes : 1, año : 1)
    
    var tic : Ticket = Ticket()
    
    var contadorParticular : Int = 0 {
        didSet {
            if contadorParticular != 0 {
                self.contParticularesNsTextField.stringValue = String(contadorParticular)
            }
        }
    }
    
    var contadorGrupo : Int = 0 {
        didSet {
            if contadorGrupo != 0 {
                self.contGruposNsTextField.stringValue = String(contadorGrupo)
            }
        }
    }
    
    let printInfo : NSPrintInfo = NSPrintInfo.sharedPrintInfo()
    /// Estas variables controlan los nstextview del listado
 /*   var total€ : Float = 0.0 {
        willSet {
            self.totalEurosNSTextField.stringValue = String(total€)
        }

    }
    var media€ : Float = 0.0 {
        willSet {
            self.mediaNSTextField.stringValue = String(media€)
        }
    }
    var numeroTickets : Int = 0 {
        willSet {
            self.totalTicketsNSTextField.stringValue = String(numeroTickets)
        }
    }*/
    
    
    @IBOutlet weak var individualButton: NSButton!
    @IBOutlet weak var gruposButton: NSButton!
    
    @IBOutlet weak var precio_8_Individual: NSButton!
    @IBOutlet weak var precio_9_Individual: NSButton!
    @IBOutlet weak var precio_10_Individual: NSButton!
    @IBOutlet weak var precio_12_Individual: NSButton!
    @IBOutlet weak var precio_750_Grupos: NSButton!
    @IBOutlet weak var precio_770_Grupos: NSButton!
    @IBOutlet weak var precio_8_Grupos: NSButton!
    @IBOutlet weak var precio_850_Grupos: NSButton!
    @IBOutlet weak var precio_9_Grupos: NSButtonCell!
    @IBOutlet weak var precio_10_Grupos: NSButtonCell!
    @IBOutlet weak var precio_11_Grupos: NSButton!
    @IBOutlet weak var precio_12_Grupos: NSButton!
    
    @IBOutlet weak var precioGruposView: NSView!
    @IBOutlet weak var precioIndividualView: NSView!

    @IBOutlet weak var listadoView: NSView!
    
    @IBOutlet weak var listadoTableView: NSTableView!
    @IBOutlet weak var totalTicketsNSTextField: NSTextField!
    @IBOutlet weak var totalEurosNSTextField: NSTextField!
    @IBOutlet weak var mediaNSTextField: NSTextField!
  
    @IBOutlet weak var ticketNSView: NSView!
    
    @IBOutlet weak var inicioNSDatePicker: NSDatePicker!
    @IBOutlet weak var finalNSDatePicker: NSDatePicker!
    
    @IBOutlet weak var contParticularesNsTextField: NSTextField!
    
    @IBOutlet weak var contGruposNsTextField: NSTextField!
    
    @IBAction  func listarNSButton(sender : NSButton) {
        
        let formato = NSDateFormatter()
        
        formato.dateFormat = "dd"
        let diaI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let diaF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        formato.dateFormat = "MM"
        let mesI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let mesF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        formato.dateFormat = "yy"
        let añoI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let añoF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        
        webService.MFlistado(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
        
        webService.MFestadisticas(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
    }
    
    @IBAction func imprimir(sender: NSButton){
        
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
    

    @IBAction func individualPushButton(sender: NSButtonCell) {
        
        if sender.state == NSOnState {
            self.precioIndividualView.hidden = false
            self.precioGruposView.hidden = true
            self.gruposButton.state = NSOffState
        } else {
            self.precioIndividualView.hidden = true
            self.precioGruposView.hidden = true
        }
        
    }
    @IBAction func gruposPushButton(sender: NSButtonCell) {
        
        if sender.state == NSOnState {
            self.precioGruposView.hidden = false
            self.precioIndividualView.hidden = true
            self.individualButton.state = NSOffState
        } else {
            self.precioGruposView.hidden = true
            self.precioIndividualView.hidden = true
        }
    }
    
    
    @IBAction func precioIndividualPushButton(sender: NSButton) {
        print(sender.title)
        print(Float(sender.title))
        if let precio : Float? = Float(sender.title) {
            webService.MFinsertar_ticket(precio!, part: 1) // Si parametro = 1 es particular
            self.contadorParticular += 1
        }
    }
    
    
    @IBAction func precioGruposPushButton(sender: NSButton) {
        print(sender.title)
        print(Float(sender.title))
        if let precio : Float? = Float(sender.title) {
             webService.MFinsertar_ticket(precio!, part: 0) // Si parametro = 0 es grupo
            self.contadorGrupo += 1
        }
    }
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contGruposNsTextField.stringValue = "0"
        self.contParticularesNsTextField.stringValue = "0"
        
        self.diaHoy = self.buscarFechaHoy()
        
        webService.delegate = self
        
        self.individualButton.setButtonType(NSButtonType.PushOnPushOffButton)
        self.gruposButton.setButtonType(NSButtonType.PushOnPushOffButton)
        
        self.precioIndividualView.hidden = true
        self.precioGruposView.hidden = true
        
        self.precioIndividualView.setFrameOrigin(NSPoint(x : 20, y : 325))
        self.precioGruposView.setFrameOrigin(NSPoint(x : 20, y : 325))
        
        webService.MFlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año,
            diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
        
        webService.MFestadisticas(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)

        self.inicioNSDatePicker.dateValue = NSDate()
        self.finalNSDatePicker.dateValue = NSDate()
        
        listadoTableView.setDelegate(self)
        listadoTableView.setDataSource(self)
        
        self.listadoTableView.reloadData()
        
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
                webService.MFlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año,
                                     diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                webService.MFestadisticas(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                
                
                numeroTic += 1
                
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
    
    func listadoMF(respuesta: [String : AnyObject]) {
        var registro : [String : AnyObject] = [:]
        self.listadoTickets = []
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            print(k)
            print(v)
            if k == "numero_particulas" {
                self.contadorParticular = v as! Int
            }
            if k == "numero_grupos" {
                self.contadorGrupo = v as! Int
            }
            
            if k != "error" && k != "numero_tickets" && k != "numero_grupos" && k != "numero_particulas" {
                registro["numero"] = v["numero"] as! Int
                if v["punto_venta"] as! Int == 1 {
                    registro["punto_venta"] = "MarinaFerry"
                } else {
                    registro["punto_venta"] = "iPad"
                }
                let formato = NSDateFormatter()
                formato.dateFormat = "dd-MM-yy HH:mm:ss"
                let fec = formato.dateFromString(v["fecha"] as! String)
                registro["fecha"] = formato.stringFromDate(fec!)
                //registro["fecha"] = v["fecha"] as! String
                
                registro["precio"] = v["precio"] as! Float
            
                self.listadoTickets.append(registro)
                
                // Insercion en la lista para impresion
                let t : Ticket = Ticket()
        
                t.numero = registro["numero"] as! Int
                t.fecha  = registro["fecha"] as! String
                t.precio = registro["precio"] as! Float
                t.base   = registro["punto_venta"] as! String
                
                tickets.append(t)
                
            }
        }
        self.listadoTickets.sortInPlace { (primero : [String : AnyObject], segundo : [String : AnyObject]) -> Bool in
            return segundo["numero"] as! Int > primero["numero"] as! Int
        }
        print("Registro para el tableview \(self.listadoTickets)")
        self.listadoTableView.reloadData()
        
    }
    
    func euros(respuesta : [String : Float]) {
        print("respuesta del servidor : total = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "total" {
                print("Total Euros : " + String(v))
                self.totalEurosNSTextField.stringValue = String(v)
               // self.total€ = Float(v)
            }
        }
        
    }
    
    
    func media(respuesta : [String : Float]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Media : " + String(v))
                self.mediaNSTextField.stringValue = String(v)
                //self.media€ = Float(v)
            }
        }
        
    }
    
    func numeroTickets(respuesta : [String : Int]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Numero Tickets : " + String(v))
                self.mediaNSTextField.stringValue = String(v)
                //self.numeroTickets = Int(v)
            }
        }
        
    }
    
    func estadisticas(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Media : " + String(Float(v as! NSNumber)))
                self.mediaNSTextField.stringValue = String(v)
            } else if k as String == "euros" {
                print("Euros : " + String(Float(v as! NSNumber)))
                self.totalEurosNSTextField.stringValue = String(v)
            } else if k as String == "total_tickets" {
                print("Tickets : " + String(Int(v as! NSNumber)))
                self.totalTicketsNSTextField.stringValue = String(v)
                
            }
                //self.numeroTickets = Int(v)
        }
    }
        

    

    
    /*    func respuesta(respuesta : [String : AnyObject]) {
    print("respuesta del servidor : \(respuesta)")
    }
    */
    
    // MARK - TableView
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        return self.listadoTickets.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIdentificador : String = ""
        // Item contiene el registro a meter en la tableView
        let item = self.listadoTickets[row]
        
        if tableColumn == tableView.tableColumns[0] { // Número
            text = String(item["numero"]! as! Int)
            celdaIdentificador = "numeroCellId"
        } else if tableColumn == tableView.tableColumns[1] { // punto_venta
            text = String(item["punto_venta"]! as! String)
            celdaIdentificador = "puntoVentaCellId"
        } else if tableColumn == tableView.tableColumns[2] { // fecha
            text = String(item["fecha"]! as! String)
            celdaIdentificador = "fechaCellId"
        } else if tableColumn == tableView.tableColumns[3] { // precio
            text = String(item["precio"]! as! Float)
            celdaIdentificador = "precioCellId"
        }

        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text
            return celda
        }
        return nil
    }

    func buscarFechaHoy() -> (Int, Int, Int) {
        let formato = NSDateFormatter()
        let fechaHoy = NSDate()
        formato.dateFormat = "dd"
        let dia = formato.stringFromDate(fechaHoy)
        formato.dateFormat = "MM"
        let mes = formato.stringFromDate(fechaHoy)
        formato.dateFormat = "yy"
        let año = formato.stringFromDate(fechaHoy)
        
        return (Int(dia)!, Int(mes)!, Int(año)!)
    }
    
}