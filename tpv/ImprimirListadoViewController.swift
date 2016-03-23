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
    
    @IBOutlet weak var tableViewScrollView: NSScrollView!
    @IBOutlet weak var boxTotalesNSBox: NSBox!
    var fecha : String = ""
    var numTickets : Int = 0
    var total : Float = 0.0
    
    let alturaPagina : Int = 750
    
    var listadoTickets = [[String : AnyObject]]()
    let numLineas = 38
    var lineaActual = 0
    var numPaginas = 0
    var paginaActual = 0
    
    @IBAction func botonImprimir(sender: NSButton) {
        for _ in 2 ... numPaginas {
            paginaActual += 1
            sender.hidden = true
            let l : listadoImpreso = listadoImpreso()
            l.print(self.viewListado)
            
            if (paginaActual == numPaginas - 1) {
                self.boxTotalesNSBox.hidden = false
                self.viewListado.setNeedsDisplayInRect(NSRect(x : 0, y : 0, width: 500, height : 775))
            }
            
            self.tableView.reloadData()
        }
        
         dismissController(self)

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
    

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        // El numero de filas = 24 y es constante
        //return self.listadoTickets.count ?? 0
        return numLineas
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        print("fila: \(row)")
        
        var text : String = ""
        var celdaIdentificador : String = ""
        // Item contiene el registro a meter en la tableView
        let item = self.listadoTickets[row + paginaActual * numLineas]
        
        
        /*
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
            text = String(item["precio"]! as! Float)
            celdaIdentificador = "precioCellId"
        }*/
        
        
        if paginaActual <= numPaginas - 1 {
            
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
                    text = String(item["precio"]! as! Float)
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
