//
//  listadoImpreso.swift
//  tpv
//
//  Created by chus on 16/3/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class listadoImpreso: NSView {

    let printInfo : NSPrintInfo = NSPrintInfo()
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    override func print(sender: AnyObject?) {
        self.printInfo.leftMargin  = 0.0
        self.printInfo.rightMargin = 0.0
        self.printInfo.topMargin = 0.0
        self.printInfo.horizontallyCentered = true
        self.printInfo.verticallyCentered = false
        self.printInfo.jobDisposition = NSPrintSpoolJob
        self.printInfo.paperSize = NSSize(width: 400, height: 2000)
        
        let op = NSPrintOperation.init(view: sender as! NSView, printInfo: self.printInfo)
        op.showsPrintPanel = true
        //op.showsPrintPanel = false
        op.runOperation()
    }
}
