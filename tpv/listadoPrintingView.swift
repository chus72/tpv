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

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
