//
//  ticketImpreso.swift
//  tpv
//  Jesús Valladolid Rebollar
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
        self.printInfo.printer = NSPrinter(name: "TSP700")!
        self.printInfo.leftMargin  = 0.0
        self.printInfo.rightMargin = 0.0
        self.printInfo.topMargin = 0.0
        self.printInfo.horizontallyCentered = true
        self.printInfo.verticallyCentered = false
        self.printInfo.jobDisposition = NSPrintSpoolJob
        self.printInfo.paperSize = NSSize(width: 190, height: 430)
        
        let op = NSPrintOperation.init(view: sender as! NSView, printInfo: self.printInfo)
        //op.showsPrintPanel = true
        op.showsPrintPanel = false
        op.runOperation()
    }
    
}
