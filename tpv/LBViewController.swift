//
//  LBViewController.swift
//  tpv
//
//  Created by chus on 6/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

public var viajes : [Viaje] = []
public var numeroVia : Int = 0

class LBViewController: NSViewController, datosBDD_LB, NSTableViewDataSource, NSTableViewDelegate {

    var webService : webServiceCallAPI_LB = webServiceCallAPI_LB()
    
    var listadoViajes = [[String : AnyObject]]()
    var listadoMensual = [[String : AnyObject]]()
    var diaHoy = (dia : 1, mes : 1, año : 1)
    
    var via : Viaje = Viaje()
    
    var blanco : Bool = true
    
    let formato : NSNumberFormatter = NSNumberFormatter()
    
    let printInfo : NSPrintInfo = NSPrintInfo.sharedPrintInfo()
    
    
    
    @IBOutlet weak var listadoView: NSView!
    @IBOutlet weak var listadoTableView: NSTableView!
 
    @IBOutlet weak var inicioNSDatePicker: NSDatePicker!
    @IBOutlet weak var finalNSDatePicker: NSDatePicker!
    
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
        
       webService.LBlistado(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
        
        webService.LBestadisticas(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)


        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formato.maximumFractionDigits = 2
        formato.minimumFractionDigits = 2
        formato.roundingMode = .RoundHalfEven

        self.diaHoy = buscarFechaHoy()
        
        self.listadoTableView.setDataSource(self)
        self.listadoTableView.setDelegate(self)
        
        webService.delegate = self
        
        webService.LBlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
        
        self.inicioNSDatePicker.dateValue = NSDate()
        self.finalNSDatePicker.dateValue = NSDate()
        
        self.listadoTableView.target = self
        self.listadoTableView.doubleAction = #selector(MFViewController.tableViewDoubleClick(_:))
        
        self.listadoTableView.reloadData()
        
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.redColor().CGColor
    }
    
    func listadoLB(respuesta : [String : AnyObject]) {
        var registro : [String : AnyObject] = [:]
        self.listadoViajes = []
        for (k,v) in respuesta {
            
            if k != "error" && k != "numero_tickets" {
                registro["numero"] = v["numero"] as! Int
                if v["barca"] as! Int == 1 {
                    registro["barca"] = "Barkito"
                } else if v["barca"] as! Int == 2 {
                    registro["barca"] = "Eléctrica"
                } else if v["barca"] as! Int == 3 {
                    registro["barca"] = "Barca"
                } else if v["barca"] as! Int == 4 {
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
                
                viajes.append(v)
            }
        }
        self.listadoViajes.sortInPlace { (primero : [String : AnyObject], segundo : [String : AnyObject]) -> Bool in
            return segundo["numero"] as! Int > primero["numero"] as! Int
        }
        
        self.listadoTableView.reloadData()
    }
    
    
    func estadisticas(_: [String : AnyObject]) {
        
    }
    
    // MARK - TableView

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        print(self.listadoViajes.count)

        return self.listadoViajes.count ?? 0
   
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        //if self.listadoViajes[row]["blanco"] == false {
         //   return nil
       // }
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
            if self.listadoViajes[row]["blanco"] == false {
                return nil
            } else {
                return celda
            }
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
