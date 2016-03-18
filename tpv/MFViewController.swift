//
//  MFViewController.swift
//  tpv
//  Jesús Valladolid Rebollar
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.

import Cocoa

public var tickets : [Ticket] = []
public var numeroTic : Int = 0

class MFViewController: NSViewController, datosBDD, NSTableViewDataSource, NSTableViewDelegate {
    
    var webService : webServiceCallAPI = webServiceCallAPI()
    //var listadoTickets = [[String : AnyObject]]?()
    var listadoTickets = [[String : AnyObject]]()
    var diaHoy = (dia : 1, mes : 1, año : 1)
    
    var tic : Ticket = Ticket()
    
    var contadorParticular : Int = 0 {
        didSet {
            self.contParticularesNsTextField.stringValue = String(contadorParticular)
          
        }
    }
    
    var contadorGrupo : Int = 0 {
        didSet {
            self.contGruposNsTextField.stringValue = String(contadorGrupo)
            
        }
    }
    
    let printInfo : NSPrintInfo = NSPrintInfo.sharedPrintInfo()
    /// Estas variables controlan los nstextview del listado
 /*   var total€ : Float = 0.0 {
        willSet {
            self.totalEurosNSTextField.stringValue = String(total€)
        }

    }
    var media€ : Float = 0.0 {
        willSet {
            self.mediaNSTextField.stringValue = String(media€)
        }
    }
    var numeroTickets : Int = 0 {
        willSet {
            self.totalTicketsNSTextField.stringValue = String(numeroTickets)
        }
    }*/
    
    
    @IBOutlet weak var individualButton: NSButton!
    @IBOutlet weak var gruposButton: NSButton!
    
    @IBOutlet weak var precio_8_Individual: NSButton!
    @IBOutlet weak var precio_9_Individual: NSButton!
    @IBOutlet weak var precio_10_Individual: NSButton!
    @IBOutlet weak var precio_12_Individual: NSButton!
    @IBOutlet weak var precio_750_Grupos: NSButton!
    @IBOutlet weak var precio_770_Grupos: NSButton!
    @IBOutlet weak var precio_8_Grupos: NSButton!
    @IBOutlet weak var precio_850_Grupos: NSButton!
    @IBOutlet weak var precio_9_Grupos: NSButtonCell!
    @IBOutlet weak var precio_10_Grupos: NSButtonCell!
    @IBOutlet weak var precio_11_Grupos: NSButton!
    @IBOutlet weak var precio_12_Grupos: NSButton!
    
    @IBOutlet weak var precioGruposView: NSView!
    @IBOutlet weak var precioIndividualView: NSView!

    @IBOutlet weak var listadoView: NSView!
    
    @IBOutlet weak var listarNSButton: NSButton!
    @IBOutlet weak var listadoTableView: NSTableView!
    @IBOutlet weak var totalTicketsNSTextField: NSTextField!
    @IBOutlet weak var totalEurosNSTextField: NSTextField!
    @IBOutlet weak var mediaNSTextField: NSTextField!
  
    @IBOutlet weak var ticketNSView: NSView!
    
    @IBOutlet weak var inicioNSDatePicker: NSDatePicker!
    @IBOutlet weak var finalNSDatePicker: NSDatePicker!
    
    @IBOutlet weak var contParticularesNsTextField: NSTextField!
    
    @IBOutlet weak var contGruposNsTextField: NSTextField!
    
    // Campos y vista de la entrada masiva de tickets para grupos
    @IBOutlet weak var ticketsMasivosNSView: NSView!
    @IBOutlet weak var numTicketsMasivos: NSTextField!
    
    /// Campos del Ticket a imprimir
    @IBOutlet weak var fechaTicketNSTextField: NSTextField!
    @IBOutlet weak var numeroTicketNSTextField: NSTextField!
    @IBOutlet weak var descripcionTicketNSTextField: NSTextField!
    @IBOutlet weak var baseTicketNSTextField: NSTextField!
    @IBOutlet weak var ivaTicketNSTextField: NSTextField!
    @IBOutlet weak var totalEurosTicketNSTextField: NSTextField!
    @IBOutlet weak var grupoParticularTicketNSTextField: NSTextField!
    
    // Botones control ticket
    @IBOutlet weak var botonesTicketNSview: NSView!
    @IBOutlet weak var imprimirTicketNSButton: NSButton!
    @IBOutlet weak var modificarTicketNSButton: NSButton!
    @IBOutlet weak var borrarTicketNSButton: NSButton!
    @IBOutlet weak var salirTicketNSButton: NSButton!
    
    ///////////////////////////////////
    
    // BOTONES DE LA VISTA PARA CAMBIAR EL PRECIO
    @IBOutlet weak var cambioPrecioNSView: NSView!
    @IBOutlet weak var nuevoPrecioNSTextField: NSTextField!
    @IBOutlet weak var okNuevoPrecioNSButton: NSButton!
    ///////////////////////////////////////////////////////////
    
    
    @IBAction  func listarNSButton(sender : NSButton) {
        
        let formato = NSDateFormatter()
        
        formato.dateFormat = "dd"
        let diaI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let diaF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        formato.dateFormat = "MM"
        let mesI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let mesF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        formato.dateFormat = "yy"
        let añoI : String = formato.stringFromDate(inicioNSDatePicker.dateValue)
        let añoF : String = formato.stringFromDate(finalNSDatePicker.dateValue)
        
        
        webService.MFlistado(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
        
        webService.MFestadisticas(Int(diaI)!, mesI: Int(mesI)!, anyoI: Int(añoI)!, diaF: Int(diaF)!, mesF: Int(mesF)!, anyoF: Int(añoF)!)
    }
    
    @IBAction func recuperar(sender: NSButtonCell) {
        webService.MFrecuperar_ticket(14)
        /*        let numero : Int = 14
        let url : String = "https://losbarkitos.herokuapp.com/MFrecuperar_ticket/" + String(numero)
        webService.MFrequestBDD(url)
        */
    }
    
    @IBAction func eurosPush(sender: NSButton) {
        webService.MFeuros(1, mesI: 1, anyoI: 15, diaF: 31, mesF: 12, anyoF: 15)
    }
    @IBAction func mediaPush(sender: NSButton) {
        webService.MFmedia(1, mesI: 1, anyoI: 15, diaF: 31, mesF: 12, anyoF: 15)
    }
    

    @IBAction func individualPushButton(sender: NSButtonCell) {
        
        if sender.state == NSOnState {
            self.precioIndividualView.hidden = false
            self.precioGruposView.hidden = true
            self.gruposButton.state = NSOffState
        } else {
            self.precioIndividualView.hidden = true
            self.precioGruposView.hidden = true
        }
        
    }
    @IBAction func gruposPushButton(sender: NSButtonCell) {
        
        if sender.state == NSOnState {
            self.precioGruposView.hidden = false
            self.precioIndividualView.hidden = true
            self.individualButton.state = NSOffState
            self.ticketsMasivosNSView.alphaValue = 1
        } else {
            self.precioGruposView.hidden = true
            self.precioIndividualView.hidden = true
            self.ticketsMasivosNSView.alphaValue = 0
        }
    }
    
    
    @IBAction func precioIndividualPushButton(sender: NSButton) {
        print(sender.title)
        print(Float(sender.title))
        if let precio : Float? = Float(sender.title) {
            webService.MFinsertar_ticket(precio!, part: 1) // Si parametro = 1 es particular
            self.contadorParticular += 1
        }
    }
    
    
    @IBAction func precioGruposPushButton(sender: NSButton) {
        print(sender.title)
        print(Float(sender.title))
        
        if Int(self.numTicketsMasivos.stringValue) == 1 {
            if let precio : Float? = Float(sender.title) {
                webService.MFinsertar_ticket(precio!, part: 0) // Si parametro = 0 es grupo
                self.contadorGrupo += 1
            }
        } else if Int(self.numTicketsMasivos.stringValue) > 1 {
            let num = Int(self.numTicketsMasivos.stringValue)!
            let precio : Float? = Float(sender.title)
            webService.MFinsertar_ticket_masivo(precio!, cantidad: num)
            self.contadorGrupo += num
       
        }
    }
    
    @IBAction func reImprimirTicketNSButton(sender: NSButton) {
        
        self.imprimirTicket()
        
    }
    
    @IBAction func modificarTicket(sender: NSButton) {
        // primero se borra el ticket y luego se inserta el nuevo
        webService.MFborrar_ticket(self.tic.numero, modo: "MODIFICAR")
    }
    
    @IBAction func borrarTicketNSButton(sender: NSButton) {
        webService.MFborrar_ticket(self.tic.numero, modo: "BORRAR")
        self.listarNSButton(self.listarNSButton)
    }
    
    
    @IBAction func salirTicketNSButton(sender: NSButton) {
   
        self.ticketNSView.alphaValue = 0
        self.botonesTicketNSview.alphaValue = 0
        
    }
    
    @IBAction func anadirNuevoPrecio(sender : AnyObject) {

        if self.precioIndividualView.hidden == false || self.precioGruposView.hidden == false {
            self.cambioPrecioNSView.hidden = false
        }
        
        
    }
    @IBAction func okNuevoPrecioPushButton(sender: NSButton) {
        
        guard let precio = Int(self.nuevoPrecioNSTextField.stringValue) else {
            self.cambioPrecioNSView.hidden = true
            return
        }
        if self.precioIndividualView.hidden ==  false {
            self.precio_12_Individual.title = String(precio)
        } else {
            self.precio_12_Grupos.title = String(precio)
        }
        self.cambioPrecioNSView.hidden = true
    }
    @IBAction func imprimirListadoPushButton(sender: NSButton) {
        
       // let size : NSSize = NSSize(width: self.listadoView.bounds.width , height: 980)
        //self.listadoView.setFrameSize(size)
        
    }
    @IBAction func poner0particularPushButton(sender: NSButton) {
        
        self.contadorParticular = 0
        
    }
    @IBAction func poner0grupoPushButton(sender: NSButton) {
        
        self.contadorGrupo = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contGruposNsTextField.stringValue = "0"
        self.contParticularesNsTextField.stringValue = "0"
        
        self.diaHoy = self.buscarFechaHoy()
        
        webService.delegate = self
        
        self.individualButton.setButtonType(NSButtonType.PushOnPushOffButton)
        self.gruposButton.setButtonType(NSButtonType.PushOnPushOffButton)
        
        self.precioIndividualView.hidden = true
        self.precioGruposView.hidden = true
        
        self.precioIndividualView.setFrameOrigin(NSPoint(x : 20, y : 325))
        self.precioGruposView.setFrameOrigin(NSPoint(x : 20, y : 325))
        
        webService.MFlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año,
            diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
        
        webService.MFestadisticas(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)

        self.inicioNSDatePicker.dateValue = NSDate()
        self.finalNSDatePicker.dateValue = NSDate()
        
        self.listadoTableView.setDelegate(self)
        self.listadoTableView.setDataSource(self)
        
        // Esto hace que los eventos sean recogidos en esta clase
        // Y envia la accion de "doble click" al nsVIew determinado
        self.listadoTableView.target = self
        self.listadoTableView.doubleAction = "tableViewDoubleClick:"
        
        self.listadoTableView.reloadData()
        
        self.cambioPrecioNSView.hidden = true
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    //  METODOS DELEGADOS DE datosBDD
    func ticketInsertado(respuesta : [String : AnyObject]) {
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 {
                print("ERROR EN EL SERVIDOR")
            } else if k as String == "error" && v as! Int == 0 {
                
                webService.MFlistado(self.diaHoy.dia, mesI: self.diaHoy.mes, anyoI: self.diaHoy.año,
                                     diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                webService.MFestadisticas(self.diaHoy.dia, mesI:self.diaHoy.mes, anyoI: self.diaHoy.año, diaF: self.diaHoy.dia, mesF: self.diaHoy.mes, anyoF: self.diaHoy.año)
                
                numeroTic += 1
                
                self.rellenarTicket(respuesta)
                self.imprimirTicket()
            }
        }
    }
    
    func ticketsInsertadosMasivos(respuesta : [String : AnyObject]) {
        var cantidad : Int = 0
        //print (respuesta)
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 1 {
                print("ERROR EN EL SERVIDOR")
            } else {
                if k as String == "cantidad" {
                    print(v as! Int)
                    cantidad = v as! Int
                } else {
                    if k as String == "numero" {
                        numeroTic = v as! Int
                    }
                }
            }
        }
        
        self.rellenarTicketsMasivos(respuesta)
        for var c = cantidad; c > 0 ; c-- {
            self.numeroTicketNSTextField.stringValue = String(numeroTic - c + 1)
            self.imprimirTicket()
        }
        
        self.listarNSButton(self.listarNSButton)
    }
    
    func ticketRecuperado(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "numero" {
                print("REGISTRO \(v as! String) RECUPERADO CORRECTAMENTE")
            }
        }
    }
    
    func ticketBorrado(respuesta: [String : AnyObject], modo : String) {
        
        //print("respuesta del servidor : \(respuesta)")
        
        for (k,v) in respuesta {
            if k as String == "numero" {
                print("REGISTRO \(v as! String) BORRADO CORRECTAMENTE")
            }
        }
        if modo == "MODIFICAR" { // es una modificacion
            self.tic.numero = Int(self.numeroTicketNSTextField.stringValue)!
            self.tic.precio = Float(self.totalEurosTicketNSTextField.stringValue)!
            self.tic.fecha = self.fechaTicketNSTextField.stringValue
            self.tic.punto = self.baseTicketNSTextField.stringValue
            if self.grupoParticularTicketNSTextField.stringValue == "PARTICULAR" {
                self.tic.particular = true
            } else {
                self.tic.particular = false
            }
            webService.MFmodificar_ticket(self.tic.numero, precio: self.tic.precio)
        }
    }
    
    func ticketModificado(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "error" && v as! Int == 0 {
                print("REGISTRO MODIFICADO")
            }
        }
    }
    
    func listadoMF(respuesta: [String : AnyObject]) {
        var registro : [String : AnyObject] = [:]
        self.listadoTickets = []
       // print("respuesta del servidor : \(respuesta)")
        for (k,v) in respuesta {
           // print(k)
           // print(v)
            /*if k == "numero_particulas" {
                self.contadorParticular = v as! Int
            }
            if k == "numero_grupos" {
                self.contadorGrupo = v as! Int
            }
            */
            if k != "error" && k != "numero_tickets" && k != "numero_grupos" && k != "numero_particulas" {
                registro["numero"] = v["numero"] as! Int
                if v["punto_venta"] as! Int == 1 {
                    registro["punto_venta"] = "MarinaFerry"
                } else {
                    registro["punto_venta"] = "iPad"
                }
                let formato = NSDateFormatter()
                formato.dateFormat = "dd-MM-yy HH:mm:ss"
                let fec = formato.dateFromString(v["fecha"] as! String)
                registro["fecha"] = formato.stringFromDate(fec!)
                //registro["fecha"] = v["fecha"] as! String
                
                registro["precio"] = v["precio"] as! Float
            
                self.listadoTickets.append(registro)
                
                // Insercion en la lista para impresion
                let t : Ticket = Ticket()
        
                t.numero = registro["numero"] as! Int
                t.fecha  = registro["fecha"] as! String
                t.precio = registro["precio"] as! Float
                t.punto  = registro["punto_venta"] as! String
                
                tickets.append(t)
                
            }
        }
        self.listadoTickets.sortInPlace { (primero : [String : AnyObject], segundo : [String : AnyObject]) -> Bool in
            return segundo["numero"] as! Int > primero["numero"] as! Int
        }
        print("Registro para el tableview \(self.listadoTickets)")
        self.listadoTableView.reloadData()
        
    }
    
    func euros(respuesta : [String : Float]) {
        print("respuesta del servidor : total = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "total" {
                print("Total Euros : " + String(v))
                self.totalEurosNSTextField.stringValue = String(v)
               // self.total€ = Float(v)
            }
        }
        
    }
    
    
    func media(respuesta : [String : Float]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Media : " + String(v))
                self.mediaNSTextField.stringValue = String(v)
                //self.media€ = Float(v)
            }
        }
        
    }
    
    func numeroTickets(respuesta : [String : Int]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
                print("Numero Tickets : " + String(v))
                self.mediaNSTextField.stringValue = String(v)
                //self.numeroTickets = Int(v)
            }
        }
        
    }
    
    func estadisticas(respuesta : [String : AnyObject]) {
        print("respuesta del servidor : media = \(respuesta)")
        for (k,v) in respuesta {
            if k as String == "media" {
              //  print("Media : " + String(Float(v as! NSNumber)))
                self.mediaNSTextField.stringValue = String(v)
            } else if k as String == "euros" {
              //  print("Euros : " + String(Float(v as! NSNumber)))
                self.totalEurosNSTextField.stringValue = String(v)
            } else if k as String == "total_tickets" {
              //  print("Tickets : " + String(Int(v as! NSNumber)))
                self.totalTicketsNSTextField.stringValue = String(v)
                
            }
                //self.numeroTickets = Int(v)
        }
    }
        

    

    
    /*    func respuesta(respuesta : [String : AnyObject]) {
    print("respuesta del servidor : \(respuesta)")
    }
    */
    
    // MARK - TableView
    
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
            text = String(item["fecha"]! as! String)
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
    
    
    func tableViewDoubleClick(sender : AnyObject?) {
        
        let fila = sender?.selectedRow!
        var datos = [String : AnyObject]()
        datos["numero"]      = self.listadoTickets[fila!]["numero"]
        datos["punto_venta"] = self.listadoTickets[fila!]["punto_venta"]
        datos["precio"]      = self.listadoTickets[fila!]["precio"]
        datos["fecha"]       = self.listadoTickets[fila!]["fecha"]
        
        rellenarTicket(datos)
        self.ticketNSView.alphaValue = 1
        self.botonesTicketNSview.alphaValue = 1
        self.modificarTicketNSButton.enabled = false
        
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////

    func buscarFechaHoy() -> (Int, Int, Int) {
        let formato = NSDateFormatter()
        let fechaHoy = NSDate()
        formato.dateFormat = "dd"
        let dia = formato.stringFromDate(fechaHoy)
        formato.dateFormat = "MM"
        let mes = formato.stringFromDate(fechaHoy)
        formato.dateFormat = "yy"
        let año = formato.stringFromDate(fechaHoy)
        
        return (Int(dia)!, Int(mes)!, Int(año)!)
    }
    
    func rellenarTicket(datos : [String : AnyObject]) {
        for (k,v) in datos {
            switch k  {
                case "numero"     : tic.numero     = v as! Int
                case "precio"     : tic.precio     = v as! Float
                case "fecha"      : tic.fecha      = v as! String
                case "punto"      : tic.punto      = v as! String
                case "particular" : tic.particular = v as! Bool
            default : break
            }
        }
        self.numeroTicketNSTextField.stringValue  = String(tic.numero)
        self.baseTicketNSTextField.stringValue    = NSString(format: "%.02f", tic.base()) as String
        self.fechaTicketNSTextField.stringValue   = String(tic.fecha)
        self.totalEurosTicketNSTextField.stringValue  = NSString(format: "%.02f", tic.precio) as String
        self.ivaTicketNSTextField.stringValue     = NSString(format: "%.02f", tic.iva()) as String
        
        if tic.particular == true {
            self.grupoParticularTicketNSTextField.stringValue = "PARTICULAR"
            self.descripcionTicketNSTextField.stringValue = "1 ticket adulto particular"
        } else {
            self.descripcionTicketNSTextField.stringValue = "1 ticket adulto grupo"
            self.grupoParticularTicketNSTextField.stringValue = "GRUPO"
        }
    }
    
    func rellenarTicketsMasivos(datos : [String : AnyObject]) {
        for (k,v) in datos {
            switch k  {
                case "numero"     : tic.numero      = v as! Int
                case "precio"     : tic.precio      = v as! Float
                case "fecha"      : tic.fecha       = v as! String
                case "punto"      : tic.punto       = v as! String
                case "particular" : tic.particular  = v as! Bool
            default : break
            }
        }
        self.numeroTicketNSTextField.stringValue  = String(tic.numero)
        self.baseTicketNSTextField.stringValue    = NSString(format: "%.02f", tic.base()) as String
        self.fechaTicketNSTextField.stringValue   = String(tic.fecha)
        self.totalEurosTicketNSTextField.stringValue  = NSString(format: "%.02f", tic.precio) as String
        self.ivaTicketNSTextField.stringValue     = NSString(format: "%.02f", tic.iva()) as String
        self.grupoParticularTicketNSTextField.stringValue = "GRUPO"
        self.descripcionTicketNSTextField.stringValue = "1 ticket adulto grupo"

    }
    
    func imprimirTicket() {
        
        // Impresion del ticket
        let t : ticketImpreso = ticketImpreso()
        t.print(self.ticketNSView)
    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let VC = segue.destinationController as! ImprimirListadoViewController
        VC.representedObject = self.listadoTickets.count
        
        let formato : NSDateFormatter = NSDateFormatter()
        formato.dateFormat = "dd / MM / yyyy"
        if self.inicioNSDatePicker.stringValue  == self.finalNSDatePicker.stringValue {
            VC.fecha = formato.stringFromDate(self.inicioNSDatePicker.dateValue)
        } else {
            VC.fecha = formato.stringFromDate(self.inicioNSDatePicker.dateValue) + " - " + formato.stringFromDate(self.finalNSDatePicker.dateValue)        }
        
        VC.total = Float(self.totalEurosNSTextField.stringValue)!
        
        VC.numTickets = Int(self.totalTicketsNSTextField.stringValue)!
        VC.listadoTickets = self.listadoTickets
    }
}