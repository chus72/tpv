//
//  Viaje.swift

import Cocoa

public class Viaje: NSObject {
    
    var numero : Int = 0
    var fecha : String = ""
    var precio : Float = 0.0
    var barca : String = ""
    var tipoBarca : Int = 0
    var puntoVenta : Int = 0
    var punto : String = ""
    var blanco : Bool = true
    
    func base() -> Float { return Float(precio / 1.21)}
    func iva() -> Float { return Float(precio - base()) }
    
    override init() {
        super.init()
    }
}
