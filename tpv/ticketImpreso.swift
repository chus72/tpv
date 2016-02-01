//
//  ticketImpreso.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 1/2/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class ticketImpreso: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override func print(sender: AnyObject?) {
        NSPrintOperation.init(view: self).runOperation()
    }
    
}
