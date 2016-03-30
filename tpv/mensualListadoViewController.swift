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
    
    var webService : webServiceCallApi2 = webServiceCallApi2()

    var numRegistros = 0
    var listado = [[String : AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        webService.delegate = self
        
        webService.MFlistadoMensual(3, ano: 16)
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
            
            print("\(pri) - \(seg)")
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
        //if let item : [String : AnyObject]? = self.listado[row]  {
            let item = self.listado[row]
            if tableColumn == tableView.tableColumns[0] {
                text = String(item["fecha"])
                celdaIdentificador = "fechaID"
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
