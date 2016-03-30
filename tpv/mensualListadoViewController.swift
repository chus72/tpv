//
//  mensualListadoViewController.swift
//  tpv
//
//  Created by chus on 30/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class mensualListadoViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var viewListado: NSView!
    @IBOutlet weak var mesNSTextField: NSTextField!
    @IBOutlet weak var tableview: NSTableView!
    
    var numRegistros = 0
    var listado = [[String : AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 1
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let celda = tableView.makeViewWithIdentifier("cantidadID", owner: nil) as? NSTableCellView {
            celda.textField?.stringValue = "hola"
            return celda
        }

        return nil
    }
    
}
