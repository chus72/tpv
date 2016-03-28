//
//  impresionMensualViewController.swift
//  tpv
//
//  Created by LosBarkitos on 26/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class impresionMensualViewController: NSViewController , NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var listadoMensualNSView: NSView!
    @IBOutlet weak var mesNSTextField: NSTextField!
    @IBOutlet weak var tableview: NSTableView!
    @IBOutlet weak var tableViewScrollView : NSScrollView!
    
    var listado = [[String : AnyObject]]()
    
    @IBAction func salirPushButton(sender: NSButton) {
        self.dismissController(self)
    }
    
    @IBAction func imprimirMensualPushButton(sender: NSButton) {
        let l : listadoImpreso = listadoImpreso()
        l.print(self.listadoMensualNSView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
         
        self.tableview.reloadData()
    }
    
    // Metodos del delegado de la tableview
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.listado.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIdentificador : String = ""
        let item = self.listado[row]
        
        if tableColumn == tableView.tableColumns[0] { // fecha
            text = String(item["fecha"]!)
            celdaIdentificador = "fechaCellId"
        } else if tableColumn == tableView.tableColumns[1] { // candidad de tickets
            text = String(item["cantidad"])
            celdaIdentificador = "cantidadCellId"
        } else if tableColumn == tableView.tableColumns[4] { // bruto
            text = String(item["bruto"])
            celdaIdentificador = "brutoCellId"
        } else if tableColumn == tableView.tableColumns[2] { // base
            text = String(item["bruto"] as! Float / 1.21)
            celdaIdentificador = "baseCellId"
        } else { // tableView.tableColumns[3] iva
            text = String((item["bruto"] as! Float) - (item["base"] as! Float))
        }
        
        
        
        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text
            return celda
        }
        return nil

    }
    
}
