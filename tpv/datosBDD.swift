//
//  datosBDD.swift
//  tpv
//
//  Created by LosBarkitos on 22/12/15.
//  Copyright © 2015 LosBarkitos. All rights reserved.
//
import Alamofire

import Foundation

protocol datosBDD {
    // Devuelve el resultado de la insercion de un ticket en MF
    func ticketInsertado(_ : [String : AnyObject])
    // Devuelve los datos de un ticket determinado
    func ticketRecuperado(_ : [String : AnyObject])
    
}




class webServiceCallAPI: NSObject {
    var delegate : datosBDD?
    
    // url(r'^MFinsertar_ticket/(\d{1,})/$', MFinsertarTicket),
    // data = {'error' : 1, 'tipo error' : 'Error en la grabacion del ticket'}
    func MFinsertar_ticket(precio : Int) {
        let url : String = "https://losbarkitos.herokuapp.com/MFinsertar_ticket/" + String(precio)
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if case let diccionario as [String : AnyObject] = response.result.value {
                   	self.delegate?.ticketInsertado(diccionario)
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
}