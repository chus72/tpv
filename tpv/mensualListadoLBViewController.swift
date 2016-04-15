//
//  mensualListadoLBViewController.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 7/4/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class mensualListadoLBViewController: NSViewController, datosBDD_LB2, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var viewListado: NSView!
    @IBOutlet weak var tableview: NSTableView!
    @IBOutlet weak var mesNsTextView: NSTextField!
    @IBOutlet weak var mesNsView: NSView!
    @IBOutlet weak var botonOkPush: NSButton!
    @IBOutlet weak var mesComboBox: NSComboBox!
    @IBOutlet weak var cerrarButton: NSButton!
    @IBOutlet weak var imprimirButton: NSButton!
    @IBOutlet weak var cambiarMesButton: NSButton!
    
    // propiedades del cuadro de totales
    @IBOutlet weak var totalNsView: NSBox!
    @IBOutlet weak var brutoMensualNsTextField: NSTextField!
    @IBOutlet weak var totalTicketsNsTextField: NSTextField!
    @IBOutlet weak var ivaTotalNsTextField: NSTextField!
    @IBOutlet weak var netoNsTextField: NSTextField!
    
    var webService : webServiceCallApiLB2 = webServiceCallApiLB2()
    
    var numRegistros = 0
    var listado = [[String : AnyObject]]()
    
    var totalTickets : Int = 0 {
        didSet {
            self.totalTicketsNsTextField.stringValue = String(self.totalTickets)
        }
    }
    
    var totalBruto : Float = 0.0 {
        didSet {
            self.brutoMensualNsTextField.stringValue = (formato.stringFromNumber(self.totalBruto as NSNumber))!
        }
    }
    
    var totalNeto : Float = 0.0 {
        didSet {
            self.netoNsTextField.stringValue = (formato.stringFromNumber(self.totalNeto as NSNumber))!
        }
    }
    
    var totalIVA : Float = 0.0 {
        didSet {
            self.ivaTotalNsTextField.stringValue = (formato.stringFromNumber(self.totalIVA as NSNumber))!
        }
    }
    
    let formato : NSNumberFormatter = NSNumberFormatter()
    
    
    @IBAction func cambiarMesPush(sender: NSButton) {
        
        self.mesNsTextView.hidden = true
        self.mesNsView.hidden = false
        self.imprimirButton.enabled = false
        sender.hidden = true
        
    }
    @IBAction func imprimir(sender: NSButton) {
        
        self.imprimirButton.hidden = true
        self.mesNsView.hidden = true
        self.cerrarButton.hidden = true
        let l : listadoImpreso = listadoImpreso()
        l.print(self.viewListado)
        self.imprimirButton.hidden = false
        self.mesNsView.hidden = false
        self.cerrarButton.hidden = false
        
        
    }
    
    @IBAction func botonOkPushButton(sender: NSButton) {
        
        
        let mes = self.mesComboBox.indexOfSelectedItem + 1
        webService.LBlistadoMensualB(mes, ano: 16)
        
        self.mesNsTextView.stringValue = self.mesComboBox.stringValue
        self.mesNsView.hidden = true
        self.mesNsTextView.hidden = false
        self.cambiarMesButton.hidden = false
        self.imprimirButton.enabled = true
        
    }
    
    @IBAction func mesNsTextFieldPush(sender: NSTextField) {
        
        self.mesNsTextView.hidden = true
        self.cambiarMesButton.hidden = true
        self.mesNsView.hidden = false
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
        
        self.mesNsView.hidden = false
        self.mesNsTextView.hidden = true
        self.cambiarMesButton.hidden = true
        self.imprimirButton.enabled = false
        
        webService.delegate = self
    }
    
    func listadoMensualLB(respuesta : [String : AnyObject]) {
        
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
            print(item["bruto"])
            if tableColumn == tableView.tableColumns[0] {
                text = String(item["fecha"]!)
                celdaIdentificador = "fechaID"
            } else if tableColumn == tableView.tableColumns[1] {
                self.totalTickets += item["cantidad"] as! Int
                text = String(item["cantidad"]!)
                celdaIdentificador = "cantidadID"
            } else if tableColumn == tableView.tableColumns[2] {
                self.totalNeto += item["base"] as! Float
                text = formato.stringFromNumber(item["base"] as! NSNumber)!
                celdaIdentificador = "baseID"
            } else if tableColumn == tableView.tableColumns[3] {
                self.totalIVA += item["iva"] as! Float
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


    
}
