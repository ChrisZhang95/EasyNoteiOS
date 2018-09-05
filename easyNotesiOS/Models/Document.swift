//
//  Document.swift
//  FilesiOS
//
//  Created by Chris Zhang on 2018-09-05.
//  Copyright © 2018 Chris Zhang. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

