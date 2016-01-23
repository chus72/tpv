//
//  listadoPrintingView.swift
//  tpv
//
//  Created by LosBarkitos on 17/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

private let font : NSFont = NSFont.userFixedPitchFontOfSize(12.0)!
private let textAttributes : [String : AnyObject] = [NSFontAttributeName : font]
private let lineHeight : CGFloat = font.capHeight * 2.0

class listadoPrintingView: NSView {
    
    let tickets  : [Ticket] // Estos son los datos a imprimir
    
    var pageRect = NSRect()
    var linesPerPage : Int = 0
    var currentPage : Int = 0
    
    init(tickets: [Ticket]) {
        self.tickets = tickets
        super.init(frame: NSRect())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func knowsPageRange(range: NSRangePointer) -> Bool {
        let printOperation = NSPrintOperation.currentOperation()
        let printInfo : NSPrintInfo = printOperation!.printInfo
        
        pageRect = printInfo.imageablePageBounds
        let newFrame = NSRect(origin: CGPoint(), size: printInfo.paperSize)
        frame = newFrame
        
        linesPerPage = Int(pageRect.height / lineHeight)
        
        var rangeOut = NSRange(location: 0, length: 0)
        
        rangeOut.location = 1
        
        rangeOut.length = tickets.count // Aqui va el numero de lineas : seria: = numero lineas / linesPerPage
        if tickets.count % linesPerPage > 0 { //  -> numero de lineas listado
            rangeOut.length += 1
        }
        
        range.memory = rangeOut
        return true
    }
    
    override func rectForPage(page: Int) -> NSRect {
        currentPage = page - 1
        return pageRect
    }
    
    override var flipped: Bool {
        return true
    }
    
    override func drawRect(dirtyRect: NSRect) {
       // super.drawRect(dirtyRect)
        var nameRect = NSRect(x: pageRect.minX, y: 0, width: 200.0, height: lineHeight)
        var raiseRect = NSRect(x: nameRect.maxX, y: 0, width: 100.0, height: lineHeight)
        
        for indexOnPage in 0..<linesPerPage {
            let indexInTickets = currentPage * linesPerPage + indexOnPage
            if indexInTickets >= 20 {// numero de tickets
                break
            }
            
            let tic = tickets[indexInTickets]
            
            nameRect.origin.y = pageRect.minY + CGFloat(indexOnPage) + lineHeight
            let ticketNumero = (tic.numero ?? 0)
            let index = "\(indexInTickets) \(ticketNumero)"
            index.drawInRect(nameRect, withAttributes: textAttributes)
            
            // Draw raise
            raiseRect.origin.y = nameRect.minY
            let raise = String(format: "%4.1f%%", "hola")//tic.fecha)
            let raiseString = raise
            raiseString.drawInRect(raiseRect, withAttributes: textAttributes)
        }

        // Drawing code here.
    }
        
}
