//
//  LBViewController.swift
//  tpv
//
//  Created by chus on 6/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class LBViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.redColor().CGColor
    }
    
}
