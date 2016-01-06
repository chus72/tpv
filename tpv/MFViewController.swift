//
//  MFViewController.swift
//  tpv
//
//  Created by chus on 6/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class MFViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        
    }
    
}
