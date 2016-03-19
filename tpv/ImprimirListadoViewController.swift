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
        let espacio : CGFloat = 600.0
        let numPaginas : Int = self.numTickets / 24
        let altura : CGFloat = CGFloat(self.alturaPagina * numPaginas)
        
        self.tableViewScrollView.setBoundsOrigin(NSPoint(x: 0, y: 170))
        
        self.viewListado.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura))
        self.tableViewScrollView.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura - 250))
        //self.tableView.setBoundsSize(NSSize(width: self.viewListado.bounds.width, height: altura))
        self.boxTotalesNSBox.setBoundsOrigin(NSPoint(x: 190, y: 50))
        
    }
    

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
            let str = String(item["fecha"]! as! String)
            let index = str.startIndex.advancedBy(8)
            text = str.substringToIndex(index)
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

    
}
