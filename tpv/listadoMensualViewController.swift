//
//  listadoMensualViewController.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 29/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class listadoMensualViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    var listado = [[String : AnyObject]]()
    var numRegistros = 0
    @IBOutlet weak var mesNSLabel: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func imprimirMensualPushButton(sender: NSButton) {
        let l : listadoImpreso = listadoImpreso()
      //  l.print(self.listadoMensualNSView)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    
    // Metodos del tableview
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.numRegistros
        
    }

    func tableView(tableView: NSTableView,  tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIdentificador : String = ""
        let item = self.listado[row]
        
        if tableColumn == tableView.tableColumns[0] { // fecha
            text = String(item["fecha"]!)
            celdaIdentificador = "fechaCellId"
        } else if tableColumn == tableView.tableColumns[1] { // candidad de tickets
            text = String(item["cantidad"])
            celdaIdentificador = "cantidadCellId"
        } else if tableColumn == tableView.tableColumns[2] { // bruto
            text = String(item["base"])
            celdaIdentificador = "baseCellId"
        } else if tableColumn == tableView.tableColumns[3] { // base
            text = String(item["iva"] as! Float / 1.21)
            celdaIdentificador = "ivaCellId"
        } else { // tableView.tableColumns[4] bruto
            text = String((item["bruto"] as! Float) - (item["base"] as! Float))
        }
        
        
        if let celda = tableView.makeViewWithIdentifier(celdaIdentificador, owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = text
            return celda
        }
        return nil
    }

    
}
