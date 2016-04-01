//
//  mensualListadoViewController.swift
//  tpv
//
//  Created by chus on 30/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa



class mensualListadoViewController: NSViewController, datosBBD2, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var viewListado: NSView!
    @IBOutlet weak var mesNSTextField: NSTextField!
    @IBOutlet weak var tableview: NSTableView!
    @IBOutlet weak var mesComboBox: NSComboBox!
    @IBOutlet weak var mesNSview: NSView!
    @IBOutlet weak var botonOKButton: NSButton!
    @IBOutlet weak var imprimirButton: NSButton!
    @IBOutlet weak var cerrarButton : NSButton!
    @IBOutlet weak var cambiarMesButton: NSButton!
    
    // propiedades del recuadro de totales
    @IBOutlet weak var total_tickets: NSTextField!
    @IBOutlet weak var neto: NSTextField!
    @IBOutlet weak var IVA: NSTextField!
    @IBOutlet weak var bruto: NSTextField!
    
    
    var webService : webServiceCallApi2 = webServiceCallApi2()

    var numRegistros = 0
    var listado = [[String : AnyObject]]()
    
    var totalTickets : Int = 0
    var totalBruto : Float = 0.0
    
    let formato : NSNumberFormatter = NSNumberFormatter()
    
    @IBAction func cambiarMesPush(sender: NSButton) {
        
        self.mesNSTextField.hidden = true
        self.mesNSview.hidden = false
        self.imprimirButton.enabled = false
        sender.hidden = true
        
    }
    @IBAction func imprimir(sender: NSButton) {
        
        self.imprimirButton.hidden = true
        self.mesNSview.hidden = true
        self.cerrarButton.hidden = true
        let l : listadoImpreso = listadoImpreso()
        l.print(self.viewListado)
        self.imprimirButton.hidden = false
        self.mesNSview.hidden = false
        self.cerrarButton.hidden = false

        
    }
    
    @IBAction func botonOkPushButton(sender: NSButton) {
        
        
        let mes = self.mesComboBox.indexOfSelectedItem + 1
        webService.MFlistadoMensual(mes, ano: 16)
        
        self.mesNSTextField.stringValue = self.mesComboBox.stringValue
        self.mesNSview.hidden = true
        self.mesNSTextField.hidden = false
        self.cambiarMesButton.hidden = false
        self.imprimirButton.enabled = true
        
    }

    @IBAction func mesNsTextFieldPush(sender: NSTextField) {
        
        self.mesNSTextField.hidden = true
        self.cambiarMesButton.hidden = true
        self.mesNSview.hidden = false
        self.imprimirButton.enabled = false
        
    }
    
    @IBAction func cerrarPush(sender: NSButton) {
        
        self.dismissController(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        formato.maximumFractionDigits = 2
        formato.minimumFractionDigits = 2
        formato.roundingMode = .RoundHalfEven

        self.mesNSview.hidden = false
        self.mesNSTextField.hidden = true
        self.cambiarMesButton.hidden = true
        self.imprimirButton.enabled = false
        
        webService.delegate = self
        totales()
        //webService.MFlistadoMensual(3, ano: 16)
    }
    
    func listadoMensualMF(respuesta : [String : AnyObject]) {
       // print("listadoMensualMF : \(respuesta)")
        var registro : [String : AnyObject] = [:]
        for (k,v) in respuesta {
            if k != "error" && k != "numero_dias" {
                registro["fecha"]    = v["fecha"] as! String
                registro["cantidad"] = v["viajes"] as! Int
                registro["base"]     = v["neto"] as! Float
                registro["iva"]      = v["iva"] as! Float
                registro["bruto"]    = v["total"] as! Float
                
                self.listado.append(registro)
            }
        }
        // ordeno la lista por fecha
        self.listado.sortInPlace { (primero : [String : AnyObject], segundo : [String : AnyObject]) -> Bool in
            var pri : String = primero["fecha"] as! String
            pri = pri.substringWithRange(Range<String.Index>(start: pri.startIndex , end: pri.endIndex.advancedBy(-5)))
            var seg : String = segundo["fecha"] as! String
            seg = seg.substringWithRange(Range<String.Index>(start: seg.startIndex, end: seg.endIndex.advancedBy(-5)))
            
            return Int(seg) > Int(pri)
        }
        
        self.tableview.reloadData()
        
    }
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.listado.count
    }
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIdentificador : String = ""
        
        if self.listado.count > 0 {
            let item = self.listado[row]
            if tableColumn == tableView.tableColumns[0] {
                text = String(item["fecha"]!)
                celdaIdentificador = "fechaID"
            } else if tableColumn == tableView.tableColumns[1] {
                self.totalTickets += item["cantidad"] as! Int
                text = String(item["cantidad"]!)
                totales()
                celdaIdentificador = "cantidadID"
            } else if tableColumn == tableView.tableColumns[2] {
                text = formato.stringFromNumber(item["base"] as! NSNumber)!
                celdaIdentificador = "baseID"
            } else if tableColumn == tableView.tableColumns[3] {
                text = formato.stringFromNumber(item["iva"] as! NSNumber)!
                celdaIdentificador = "ivaID"
            } else {
                self.totalBruto += item["bruto"] as! Float
                text = formato.stringFromNumber(item["bruto"] as! NSNumber)!
                celdaIdentificador = "brutoID"
            }
        
        
            if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
                celda.textField?.stringValue = text
                return celda
            }

        
        } else {
            return nil
        }

        return nil
    }
    
    func totales() {
        self.total_tickets.stringValue = String(self.totalTickets)
        self.bruto.stringValue = (formato.stringFromNumber(self.totalBruto as NSNumber))!
        self.neto .stringValue = (formato.stringFromNumber((self.totalBruto  / 1.21) as NSNumber))!
        self.IVA.stringValue = (formato.stringFromNumber(self.totalBruto - (self.totalBruto / 1.21)))!
    }
    
}
