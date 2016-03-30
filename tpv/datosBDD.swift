//
//  datosBDD.swift
//  tpv
//  Jesús Valladolid Rebollar
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.
//
import Alamofire

import Foundation

protocol datosBDD {
    // Devuelve el resultado de la insercion de un ticket en MF
    func ticketInsertado(_ : [String : AnyObject])
    // Devuelve el resultado de la insercion masiva de tickets
    func ticketsInsertadosMasivos(_ : [String : AnyObject])
    // Devuelve los datos de un ticket determinado
    func ticketRecuperado(_ : [String : AnyObject])
    // Devuelve el total de Euros en un periodo determinado
    func ticketBorrado(_ : [String :AnyObject], modo : String)
    // Devuelve el resultado de la modificación de un ticket en MF
    func ticketModificado(_ : [String : AnyObject])
    // Devuelve los euros de un periodo determinado
    func euros(_ : [String : Float])
    func media(_: [String : Float]) // Devuelve la media de un periodo determinado
    func numeroTickets (_ : [String : Int])
    func estadisticas(_ : [String : AnyObject])
    // Funcion que devuelva el listado segun las fechas indicadas
    func listadoMF(_ : [String : AnyObject])
       
}

protocol datosBBD2 {
    func listadoMensualMF(_ : [String : AnyObject])

}

class webServiceCallApi2 : NSObject {
    var delegate : datosBBD2?
    
    
    func MFlistadoMensual(mes : Int, ano : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFlistado_mensual/" + String(mes) + "/" + String(ano)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.listadoMensualMF(diccionario)
                }
        }
    }

}

class webServiceCallAPI: NSObject {
    var delegate : datosBDD?
    
/*    func MFrequestBDD(url : String) {
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.respuesta(diccionario)
                }
        }
    }
*/
    // url(r'^MFinsertar_ticket/(\d{1,})/$', MFinsertarTicket),
    // data = {'error' : 1, 'tipo error' : 'Error en la grabacion del ticket'}
    func MFinsertar_ticket(precio : Float, part : Int) {
        let url : String = "https://losbarkitos.herokuapp.com/MFinsertar_ticket/" + String(Int(precio * 100)) + "/" + String(part)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                   	self.delegate?.ticketInsertado(diccionario)
                }
            }
    }
    
    func MFinsertar_ticket_masivo(precio : Float, cantidad : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFinsertar_tickets_masivos/" + String(Int(precio * 100)) +
            "/" + String(cantidad)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case  let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.ticketsInsertadosMasivos(diccionario)
                }
            }
    }
    //url(r'^MFrecuperar_ticket/(\d{1,})/$', MFrecuperarTicket),
    //data = {'error' : 0, 'numero' : numero, 'precio' : float(ticket.precio), 'fecha' : datetime.strftime(ticket.fecha, "%H:%M:%S"), 'punto_venta' : 1, 'vendedor' : 1, 'particular' : ticket.part, 'blanco' : ticket.blanco}
    func MFrecuperar_ticket(numero : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFrecuperar_ticket/" + String(numero)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccinario as [String : AnyObject] = response.result.value {
                    self.delegate?.ticketRecuperado(diccinario)
                }
            }
    }
    
    //url(r'^MFborrar_ticket/(\d{1,})/$', MFborrarTicket),
    //data = {'error' : 0, 'numero' : numero, 'precio' : float(ticket.precio), 'fecha' : datetime.strftime(ticket.fecha,"%H:%M:%S")}
    func MFborrar_ticket(numero : Int, modo : String) {
        let url : String = "http://losbarkitos.herokuapp.com/MFborrar_ticket/" + String(numero)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.ticketBorrado(diccionario, modo: modo)
                }
        }
    }
    
    //
    func MFmodificar_ticket(numero : Int, precio : Float) {
        let url : String = "http://losbarkitos.herokuapp.com/MFmodificar_ticket/" + String(numero) + "/" +
                  String(Int(precio + 100)) 
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.ticketModificado(diccionario)
                }
        }
    }
    //url(r'^MFlistado/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/$', MFlistado),
    // datos = {'numero' : ticket.numero, 'precio' : float(ticket.precio), 'fecha' : datetime.strftime(ticket.fecha, "%d-%m-%Y %H:%M:%S"), 'punto_venta' : 1, 'vendedor' : 1, 'particular' : ticket.part, 'blanco' : ticket.blanco}
        //dict_tickets[str(i)] = datos
    func MFlistado(diaI : Int, mesI : Int, anyoI : Int, diaF : Int, mesF : Int, anyoF : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFlistado/" + String(diaI) + "/" + String(mesI) + "/" + String(anyoI) + "/" + String(diaF) + "/" + String(mesF) + "/" + String(anyoF)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.listadoMF(diccionario)
                }
                
        }
    }

    
    //url(r'^MFeuros/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/$', MFeuros),
    //datos = {'error' : 0, 'total' : total}
    func MFeuros(diaI : Int, mesI : Int, anyoI : Int, diaF : Int, mesF : Int, anyoF : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFeuros/" + String(diaI) + "/" + String(mesI) + "/" + String(anyoI) + "/" + String(diaF) + "/" + String(mesF) + "/" + String(anyoF)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : Float] = response.result.value {
                    self.delegate?.euros(diccionario)
                }
                
        }
    }
    
    ///url(r'^MFmedia/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/$', MFmedia),
    //datos = {'error' : 0, 'media' : media}
    func MFmedia(diaI : Int, mesI : Int, anyoI : Int, diaF : Int, mesF : Int, anyoF : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFmedia/" + String(diaI) + "/" + String(mesI) + "/" + String(anyoI) + "/" + String(diaF) + "/" + String(mesF) + "/" + String(anyoF)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : Float] = response.result.value {
                    self.delegate?.media(diccionario)
                }
                
        }


    }
    
    func MFnumeroTickets(diaI : Int, mesI : Int, anyoI : Int, diaF : Int, mesF : Int, anyoF : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFnum_tickets/" + String(diaI) + "/" + String(mesI) + "/" + String(anyoI) + "/" + String(diaF) + "/" + String(mesF) + "/" + String(anyoF)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : Int] = response.result.value {
                    self.delegate?.numeroTickets(diccionario)
                }
                
        }
        
        
    }
    
    ///  url(r'^MFestadisticas/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/(\d{1,2})/$'
    /// datos = {'error' : 0, 'media' : media, 'total_tickets' : total_tickets, 'euros' : total_euros}
    func MFestadisticas(diaI : Int, mesI : Int, anyoI : Int, diaF : Int, mesF : Int, anyoF : Int) {
        let url : String = "http://losbarkitos.herokuapp.com/MFestadisticas/" + String(diaI) + "/" + String(mesI) + "/" + String(anyoI) + "/" + String(diaF) + "/" + String(mesF) + "/" + String(anyoF)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                    self.delegate?.estadisticas(diccionario)
                }
                
        }
    
    }
    
}