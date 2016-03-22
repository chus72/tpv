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
    let numLineas = 40
    var lineaActual = 0
    var numPaginas = 0
    var paginaActual = 0
    
    @IBAction func botonImprimir(sender: NSButton) {
        
        
        sender.hidden = true
        let l : listadoImpreso = listadoImpreso()
        l.print(self.viewListado)
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
        // Do view setup here.
        numPaginas = self.numTickets / 24
       // let altura : CGFloat = CGFloat(self.alturaPagina * numPaginas)
        
        
        //self.viewListado.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura))
        //self.tableViewScrollView.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura - 250))
      //  self.tableView.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura))
        
       // self.tableViewScrollView.setBoundsOrigin(NSPoint(x: 0, y: 170))
        
        self.boxTotalesNSBox.setBoundsSize((NSSize(width: 136, height: 124)))
        self.boxTotalesNSBox.setBoundsOrigin(NSPoint(x: 187, y: 16))
        
        print(self.viewListado.bounds.size, self.viewListado.bounds.origin)
        print(self.tableViewScrollView.bounds.size, self.tableViewScrollView.bounds.origin)
        print(self.tableView.bounds.size, self.tableView.bounds.origin)
        
        lineaActual = 1
    }
    

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        return self.listadoTickets.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        print("fila: \(row)")
        
        var text : String = ""
        var celdaIdentificador : String = ""
        // Item contiene el registro a meter en la tableView
        let item = self.listadoTickets[row]
        
        
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
        
        
        if paginaActual < numPaginas  && (row / 4) < numLineas {
            
        //    if paginaActual == (numLineas % numPaginas) + 1 {
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

          //  }
            
        }
        
        if lineaActual == numLineas {
            paginaActual += 1
        }
        
        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text
            return celda
        }
        return nil
    }

    
}
