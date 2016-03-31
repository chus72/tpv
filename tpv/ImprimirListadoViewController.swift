//
//  ImprimirListadoViewController.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 16/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class ImprimirListadoViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet var viewListado: NSView!

    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var fechaTextField: NSTextField!
    @IBOutlet weak var numTicketsTextField: NSTextField!
    @IBOutlet weak var totalTextField: NSTextField!
    
    @IBOutlet weak var botonImprimirPushButton : NSButton!
    @IBOutlet weak var salirButton: NSButton!
    
    @IBOutlet weak var tableViewScrollView: NSScrollView!
    @IBOutlet weak var boxTotalesNSBox: NSBox!
    
    
    var fecha : String = ""
    var numTickets : Int = 0
    var total : Float = 0.0
    
    let alturaPagina : Int = 750
    
    var listadoTickets = [[String : AnyObject]]()
    let numLineas = 38
    var lineaActual = 0
    var numPaginas = 1
    var paginaActual = 0
    
    @IBAction func botonImprimir(sender: NSButton) {
        self.botonImprimirPushButton.hidden = true
        self.salirButton.hidden = true
        
        if self.listadoTickets.count > self.numLineas {
            for _ in 2 ... numPaginas + 1 {
                sender.hidden = true
                let l : listadoImpreso = listadoImpreso()
                l.print(self.viewListado)
            
                if (paginaActual == numPaginas ) {
                }
                paginaActual += 1
                self.tableView.reloadData()
            }
        }
        self.boxTotalesNSBox.hidden = false
        self.viewListado.setNeedsDisplayInRect(NSRect(x : 0, y : 0, width: 500, height : 775))
        let l : listadoImpreso = listadoImpreso()
        l.print(self.viewListado)
        self.botonImprimirPushButton.hidden = true
        self.salirButton.hidden = true

        dismissController(self)

    }
    
    @IBAction func salirPushButton(sender: NSButton) {
        
        self.dismissController(self)
        
    }
    
    override func viewWillAppear() {
        self.fechaTextField.alignment = NSTextAlignment.Natural
        self.fechaTextField.stringValue = self.fecha
        self.numTicketsTextField.stringValue = String(self.numTickets)
        self.totalTextField.stringValue = String(self.total)

    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        numPaginas = self.numTickets / numLineas
        lineaActual = 1
        
        self.boxTotalesNSBox.hidden = true
    
    }
    

    // Metodos del delegado de la tableview
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        // El numero de filas = 24 y es constante
        //return self.listadoTickets.count ?? 0
        return numLineas
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let formato : NSNumberFormatter = NSNumberFormatter()
        formato.maximumFractionDigits = 2
        formato.minimumFractionDigits = 2
        formato.roundingMode = .RoundHalfEven

        
        var text : String = ""
        var celdaIdentificador : String = ""
        // Item contiene el registro a meter en la tableView
        var item = [String : AnyObject]()
        var b : Bool = true
        
        if (row + (paginaActual * numLineas)) < self.listadoTickets.count {
             item = self.listadoTickets[row + (paginaActual * numLineas)]
        } else {
            
            b = false
            
        }

        if b {
                if tableColumn == tableView.tableColumns[0] { // Número
                    text = String(item["numero"]! as! Int)
                    celdaIdentificador = "numeroCellId"
                } else if tableColumn == tableView.tableColumns[1] { // punto_venta
                    text = String(item["punto_venta"]! as! String)
                    celdaIdentificador = "puntoVentaCellId"
                } else if tableColumn == tableView.tableColumns[2] { // fecha
                    let str = String(item["fecha"]! as! String)
                    let index = str.startIndex.advancedBy(8)
                    text = str.substringToIndex(index)
                    celdaIdentificador = "fechaCellId"
                } else if tableColumn == tableView.tableColumns[3] { // precio
                    text = formato.stringFromNumber(item["precio"] as! NSNumber)!
                    celdaIdentificador = "precioCellId"
                }
            
        }
        
        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text
            return celda
        }
        return nil
    }

    
}
