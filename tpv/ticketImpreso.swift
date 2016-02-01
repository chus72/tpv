//
//  ticketImpreso.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 1/2/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class ticketImpreso: NSView {
    
    let printInfo : NSPrintInfo = NSPrintInfo()

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override func print(sender: AnyObject?) {
        self.printInfo.paperSize = NSSize(width: 496, height: 1000)

        
        NSPrintOperation.init(view: self, printInfo: printInfo).runOperation()
    }
    
}
