//
//  DocumentPrint.swift
//  tpv
//
//  Created by LosBarkitos on 19/1/16.
//  Copyright © 2016 LosBarkitos. All rights reserved.
//

import Cocoa

class DocumentPrint: NSDocument {

    override var windowNibName: String? {
        // Override returning the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
        return "DocumentPrint"
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    
    override func dataOfType(typeName: String) throws -> NSData {
        // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func readFromData(data: NSData, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
    
}
