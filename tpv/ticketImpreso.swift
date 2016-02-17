//
//  ticketImpreso.swift
//  tpv
//
//  Created by Jesus Valladolid Rebollar on 1/2/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class ticketImpreso: NSView {
    
    //let nombrePrinter : NSPrinter = NSPrinter(name: "BILOXON SRP-350")!
    let printInfo : NSPrintInfo = NSPrintInfo()

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        
    }
    
    override func print(sender: AnyObject?) {
        self.printInfo.leftMargin  = 1.0
        self.printInfo.rightMargin = 0.5
        self.printInfo.horizontallyCentered = true
        self.printInfo.jobDisposition = NSPrintSpoolJob
        self.printInfo.paperSize = NSSize(width: 496, height: 1000)
        
        let op = NSPrintOperation.init(view: self, printInfo: self.printInfo)
        op.showsPrintPanel = false
        op.runOperation()
    }
    
}
