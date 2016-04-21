//
//  LBViewController.swift
//  tpv
//
//  Created by chus on 6/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

public var viajes : [Viaje] = []
public var viajesB: [Viaje] = []
public var numeroVia : Int = 0
public var TP : Int = 0 // tipo de barca

public let MARINAFERRY  = 1
public let MARINAFERRY2 = 5
public let LOSBARKITOS  = 2

public let BARKITO   = 1
public let ELECTRICA = 2
public let BARCA     = 3
public let GOLD      = 4

class LBViewController: NSViewController, datosBDD_LB, NSTableViewDataSource, NSTableViewDelegate {

    var viaje : Viaje = Viaje()
    var reservas : [Int] = [0,0,0,0]
    var tipoReserva : Int = 0
    var numeroReserva : Int = 0

    var webService : webServiceCallAPI_LB = webServiceCallAPI_LB()
    
    var listadoViajes = [[String : AnyObject]]()
    var listadoViajesB = [[String : AnyObject]]()
 //   var listAux = [[String : AnyObject]]()
    var listadoMensual = [[String : AnyObject]]()
    var diaHoy = (dia : 1, mes : 1, año : 1)
    
    var via : Viaje = Viaje()
    
    var blanco : Bool = true
    
    let formato : NSNumberFormatter = NSNumberFormatter()
    
    let printInfo : NSPrintInfo = NSPrintInfo.sharedPrintInfo()
    
    let color : CGColor = NSColor(red: 200, green: 0, blue: 0, alpha: 0.3).CGColor
    let colorB: CGColor = NSColor(red: 200, green: 0, blue: 0, alpha: 0.6).CGColor
    
    
    ///////////////////////////////////////////
    // CAMPOS DEL TICKET A IMPRIMIR
    /// Campos del Ticket a imprimir
   
    @IBOutlet weak var viajeNSView: NSView!
    @IBOutlet weak var fechaTicketNSTextField: NSTextField!
    @IBOutlet weak var numeroTicketNSTextField: NSTextField!
    @IBOutlet weak var descripcionTicketNSTextField: NSTextField!
    @IBOutlet weak var baseTicketNSTextField: NSTextField!
    @IBOutlet weak var ivaTicketNSTextField: NSTextField!
    @IBOutlet weak var totalEurosTicketNSTextField: NSTextField!
    
    @IBOutlet weak var checkNegro: NSButton!
    
    //////////////////////////////////////////////////////
    
    @IBOutlet weak var ticketNSBox: NSBox!
    @IBOutlet weak var barkitosNSButton: NSButton!
    @IBOutlet weak var barcaNSButton: NSButton!
    @IBOutlet weak var electricaNSButton: NSButton!
    @IBOutlet weak var goldNSButton: NSButton!
    @IBOutlet weak var preciosNSBox: NSBox!
    
    
    
    //////////////////////////////////////////////////////
    
    @IBAction func tipoBarcaNSButton(sender: NSButton) {
        
        self.ticketNSBox.hidden = true
        self.preciosNSBox.hidden = false
        viaje.tipoBarca = sender.tag
    }
    
    @IBAction func precioNSButton(sender: NSButton) {
        
        viaje.puntoVenta = MARINAFERRY
        viaje.precio = Float(sender.title)!
        viaje.blanco = true
        
        self.preciosNSBox.hidden = true
        self.ticketNSBox.hidden = false
  
        if let precio : Float? = Float(sender.title) {
            webService.LBinsertar_viaje(precio!, tipo: viaje.tipoBarca, blanco: 1)
        }
        
       
    }

    
    @IBAction func cancelarPrecioPush(sender: NSButton) {
        
        self.preciosNSBox.hidden = true
        self.ticketNSBox.hidden = false
        viaje.tipoBarca = 0
    }
    
    ///////////////////////////////////////////////////////
    @IBOutlet var viewLB: NSView!
    @IBOutlet weak var listadoView: NSView!
    @IBOutlet weak var listadoTableView: NSTableView!
 
    @IBOutlet weak var inicioNSDatePicker: NSDatePicker!
    @IBOutlet weak var finalNSDatePicker: NSDatePicker!
    
    // Resumen de los listados - Afecta a la Celia
    @IBOutlet weak var resumenNSBox: NSBox!
    @IBOutlet weak var numTickets: NSTextField!
    @IBOutlet weak var total: NSTextField!
    @IBOutlet weak var media: NSTextField!
    @IBOutlet weak var fecha: NSTextField!
    
    // Resumen de los listados total
    var numTicketsTotal : Int?
    var totalTotal : Float?
    ///////////////////////////////////////
    

    @IBAction func checkNegro(sender: NSButton) {
        if self.checkNegro.state == NSOnState {
            self.blanco = false
        } else {
            self.blanco = true
        }
        if self.blanco == true {
            self.view.layer?.backgroundColor = self.colorB
        } else {
            self.view.layer?.backgroundColor = self.color
        }

    }
    
    @IBAction func swich(sender: NSSegmentedControl) {
        
         
    }
    
    @IBAction func listarNSButton(sender: NSButton) {
        
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
        
        if self.blanco == true {
            webService.LBlistadoB(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
        
            webService.LBestadisticasB(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
            print(self.diaHoy)
            webService.LBestadisticasTotalesB(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)

            
        } else {
            webService.LBlistado(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
            
            webService.LBestadisticas(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
            webService.LBestadisticasTotales(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)


        }

    }
    
    @IBAction func imprimirResumenPushButton(sender: NSButton) {
        self.resumenNSBox.hidden = false
        self.imprimirResumen()
        self.resumenNSBox.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preciosNSBox.hidden = true
        self.ticketNSBox.hidden = false
        
        
        
        // Se empieza con blanco

        self.checkNegro.state = NSOffState
        self.blanco = true
        
        formato.maximumFractionDigits = 2
        formato.minimumFractionDigits = 2
        formato.roundingMode = .RoundHalfEven
        
        self.resumenNSBox.hidden = true

        self.diaHoy = buscarFechaHoy()
        
        self.listadoTableView.setDataSource(self)
        self.listadoTableView.setDelegate(self)
        
        webService.delegate = self
        
        if self.blanco == true {
            webService.LBlistadoB(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
            webService.LBestadisticasB(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
            webService.LBestadisticasTotalesB(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)

        } else {
            webService.LBlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
            webService.LBestadisticas(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
            webService.LBestadisticasTotales(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)

            
        }
        
//        webService.LBestadisticasTotalesB(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
        
        
        self.inicioNSDatePicker.dateValue = NSDate()
        self.finalNSDatePicker.dateValue = NSDate()
        
        self.listadoTableView.target = self
        self.listadoTableView.doubleAction = #selector(MFViewController.tableViewDoubleClick(_:))
        
        self.listadoTableView.reloadData()
        
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = self.colorB
    }
    
    func viajeInsertado(respuesta : [String : AnyObject]) {
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 {
                print("ERROR DEL SERVIDOR")
            } else if k as String == "error" && v as! Int == 0 {
                webService.LBlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                webService.LBestadisticas(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                
                self.rellenarViaje(respuesta)
                self.imprimirViaje()
            }
        }
    }
    
    
    func listadoLB(respuesta : [String : AnyObject]) {
        var registro : [String : AnyObject] = [:]
        self.listadoViajes = []
        for (k,v) in respuesta {
            
            if k != "error" && k != "numero_tickets" {
                registro["numero"] = v["numero"] as! Int
                if v["barca"] as! Int == BARKITO {
                    registro["barca"] = "Barkito"
                } else if v["barca"] as! Int == ELECTRICA {
                    registro["barca"] = "Eléctrica"
                } else if v["barca"] as! Int == BARCA {
                    registro["barca"] = "Barca"
                } else if v["barca"] as! Int == GOLD {
                    registro["barca"] = "Gold"
                }

                if v["punto_venta"] as! Int == 1 {
                    registro["punto_venta"] = "MarinaFerry"
                } else {
                    registro["punto_venta"] = "iPad"
                }
                
                if v["blanco"] as! Int == 1 {
                    registro["blanco"] = true
                } else {
                    registro["blanco"] = false
                }
                
                let formato = NSDateFormatter()
                formato.dateFormat = "dd-MM-yy HH:mm:ss"
                let fec = formato.dateFromString(v["fecha"] as! String)
                registro["fecha"] = formato.stringFromDate(fec!)
                
                registro["precio"] = v["precio"] as! Float
                
                self.listadoViajes.append(registro)
                
                // INserción en la lista para impresión 
                let v : Viaje = Viaje()
                
                v.numero = registro["numero"] as! Int
                v.barca = registro["barca"] as! String
                v.fecha = registro["fecha"] as! String
                v.precio = registro["precio"] as! Float
                v.punto = registro["punto_venta"] as! String
                v.blanco = registro["blanco"] as! Bool
                
                viajes.append(v)
                
            }
        }
        self.listadoViajes.sortInPlace { (primero : [String : AnyObject], segundo : [String : AnyObject]) -> Bool in
            return segundo["numero"] as! Int > primero["numero"] as! Int
        }
        
        self.listadoTableView.reloadData()
    }
    
    
    func estadisticas(respuesta : [String : AnyObject]) {
        // print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 { // Error en el servidor
                print("EROR")
            } else if k as String == "media" {
                //  print("Media : " + String(Float(v as! NSNumber)))
                self.media.stringValue = String(v)
            } else if k as String == "euros" {
                //  print("Euros : " + String(Float(v as! NSNumber)))
                self.total.stringValue = String(v)
            } else if k as String == "total_tickets" {
                //  print("Tickets : " + String(Int(v as! NSNumber)))
                self.numTickets.stringValue = String(v)
                
            }
            let formato : NSDateFormatter = NSDateFormatter()
            formato.dateFormat = "dd / MM / yyyy"
            self.fecha.stringValue = formato.stringFromDate(self.inicioNSDatePicker.dateValue)
            //self.numeroTickets = Int(v)
        }
    }
    
    func estadisticasTotales(respuesta: [String : AnyObject]) {
       // print(respuesta)
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 { // Error en el servidor
                print("ERROR")
            } else if k as String == "total_tickets" {
                self.numTicketsTotal = v as? Int
            } else if k as String == "euros" {
                self.totalTotal = v as? Float
                
            }
            self.fecha.stringValue = self.inicioNSDatePicker.stringValue
            //self.numeroTickets = Int(v)
        }

    }
    
    
    func imprimirResumen() {
        // Impresion de un ticket resumen del dia
        let t : ticketImpreso = ticketImpreso()
        t.print(self.resumenNSBox as NSView)
    }

    
    // MARK - TableView

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {

        return self.listadoViajes.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIdentificador : String = ""
        // Item contiene el registro a meter en la Tableview
        let item = self.listadoViajes[row]
        if tableColumn == tableView.tableColumns[0] { // Número
            text = String(item["numero"]! as! Int)
            celdaIdentificador = "numeroCellId"
        } else if tableColumn == tableView.tableColumns[1] { // punto venta
            text = String(item["barca"]! as! String)
            celdaIdentificador = "tipoCellId"
        } else if tableColumn == tableView.tableColumns[2] { // precio
            text = formato.stringFromNumber(item["precio"] as! NSNumber)!
            celdaIdentificador = "precioCellId"
        }
        
        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text

                return celda
         
        }
        return nil
    }
        
/*
    func montarBlanco() {
        
        for v in self.listadoViajes {
            if v["blanco"] as! Bool == true {
                self.listadoViajesB.append(v)
            }
        }
        for v in viajes {
            if v.blanco  == true {
                viajesB.append(v)
            }
        }
    }*/
    
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
    
    func rellenarViaje(datos : [String : AnyObject]) {
        print(datos)
        for (k,v) in datos {
            switch k {
                case "numero"       : viaje.numero = v as! Int
                case "precio"       : viaje.precio = v as! Float
                case "fecha"        : viaje.fecha  = v as! String
                case "blanco"       : viaje.blanco = true
                case "punto"        : viaje.puntoVenta = 1
                                      viaje.punto = "MarinaFerry"
               // case "tipo"         : viaje.tipoBarca = v as! Int
                case "barca"        : viaje.barca = v as! String
            default : break
            }
        }
        
        self.numeroTicketNSTextField.stringValue = String(viaje.numero)
        self.totalEurosTicketNSTextField.stringValue = String(viaje.precio)
        self.ivaTicketNSTextField.stringValue = String(viaje.precio - viaje.precio / 1.21)
        self.baseTicketNSTextField.stringValue = String(viaje.precio / 1.21)
        self.descripcionTicketNSTextField.stringValue = "Viaje en LosBarkitos con \(viaje.barca)"
        self.fechaTicketNSTextField.stringValue = String(viaje.fecha)
        
    }
    
    func imprimirViaje() {
        
        // Impresion del viaje
        let t : ticketImpreso = ticketImpreso()
        t.print(self.viajeNSView)
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueImprimirListadoBarkitos" {
            let VC = segue.destinationController as! imprimirListadoLBViewController
            VC.representedObject = self.listadoViajes.count

            let formato : NSDateFormatter = NSDateFormatter()
            formato.dateFormat = "dd / MM / yyyy"
            if self.inicioNSDatePicker.stringValue  == self.finalNSDatePicker.stringValue {
                VC.fecha = formato.stringFromDate(self.inicioNSDatePicker.dateValue)
            } else {
                VC.fecha = formato.stringFromDate(self.inicioNSDatePicker.dateValue) + " - " + formato.stringFromDate(self.finalNSDatePicker.dateValue)
            }
            
            VC.listadoTickets = self.listadoViajes
            VC.total = self.totalTotal!
            VC.numTickets = self.numTicketsTotal!
        } else if segue.identifier == "segueMensual_LB" {
            let VC = segue.destinationController as! mensualListadoLBViewController
            VC.numRegistros = self.listadoMensual.count
            VC.listado = self.listadoMensual
        } else if segue.identifier == "segueReserva" {
            let VC = segue.destinationController as! Reserva
             self.tipoReserva = sender!.tag
            VC.tipo = self.tipoReserva
        }
    }

    
}
