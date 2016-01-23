//
//  Tickets.swift
//  tpv
//
//  Created by LosBarkitos on 17/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

public class Ticket: NSObject {
    
        var numero : Int = 0
        var fecha : String = ""
        var precio : Float = 0.0
        var base : String = ""
 
    override init() {
        super.init()
    }
}
