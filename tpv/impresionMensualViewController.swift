//
//  impresionMensualViewController.swift
//  tpv
//
//  Created by LosBarkitos on 26/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class impresionMensualViewController: NSViewController , NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var mesNSTextField: NSTextField!
    @IBOutlet weak var tableview: NSTableView!
    @IBOutlet var listadoMensualNSView: NSView!
    
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
    }
    
    // Metodos del delegado de la tableview
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.listado.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text : String = ""
        var celdaIndentificador : String = ""
        let item = self.listado[row]
        
        if tableColumn == tableView.tableColumns[0] { // fecha
            text = String(item("fecha")!)
            
        }
    }
    
}
