//
//  main.swift
//  analyzeText
//
//  Created by john jozwiak on 2019-05-13.
//  Copyright © 2019 john jozwiak. All rights reserved.
//

import Foundation

//  gobble stdin, line by line.

var lineNumber : UInt32 = 0
var line : String?
var uniqWords = Set<String>()

line = readLine(strippingNewline: true)
while (line != nil) {
//    let definitionFound : String? = lookUp( line! )
    let tokenlets = examineLine( line! )
    if (tokenlets.count != 0) {
        print("\(tokenlets.count) : \(tokenlets) : " + line!)
    }
    lineNumber += 1
    
    for w in tokenlets {
        uniqWords.insert( w.lowercased() )
    }
    line = readLine(strippingNewline: true)
}

print("\n\(lineNumber) lines were read.\n\(uniqWords.count) unique words were seen.\nThat is all.")
