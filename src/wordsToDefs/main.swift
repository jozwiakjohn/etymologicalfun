//
//  main.swift
//  wordToDefs
//
//  Created by john jozwiak on 2019/5/6.
//  Copyright © 2019 john jozwiak. All rights reserved.
//
//  based off https://crunchybagel.com/building-command-line-tools-with-swift/
//  reference https://stackoverflow.com/questions/24581517/read-a-file-url-line-by-line-in-swift
//
//  The point of this program is to read, on stdin, a list of words,
//  one per input line, and look each up with macOS Dictionary Services,
//  writing the word and its found definition string to stdout.

import Foundation
import Swift
import Darwin
import CoreServices.DictionaryServices

//func lookUp( word : [CChar] ) -> [CChar]
//{
////  NSString * search = [NSString stringWithCString: word encoding: NSUTF8StringEncoding];
//    let e = NSString?("eviscerate".cString(using: String.Encoding.utf8)
//    let def = DCSCopyTextDefinition( nil, e, CFRangeMake(0, 10/*word.lengthOfBytes(using: UTF8)*/) )
////    NSString * output = [NSString stringWithFormat: @"Definition of <%@>: %@", search, (__bridge NSString *)def];
//    return def!.takeUnretainedValue()
//}

func  lookUp( word: String ) -> String?
{
    let nsstring = word as NSString
    let cfrange = CFRange( location: 0 , length: word.count/*nsstring.length*/ )
    guard
        let definition = DCSCopyTextDefinition( nil, nsstring, cfrange )
        else { return nil }
    
    return String(definition.takeUnretainedValue())
}

func  debug( _ word:String )
{
   var w : String
   var t : String?
   w = word
   t = lookUp( word:w )
   print( t ?? "")
}

//debug("ac-")
//debug("-ac")
//debug("ac")
//exit(EXIT_SUCCESS)

//  gobble stdin, line by line.

var line : String?
line = readLine(strippingNewline: true)
while (line != nil) {
    let definitionFound = lookUp( word: line! )
    if (definitionFound != nil) {
        let output : String = line! + " :: " + (definitionFound ?? "")
        print(output)
    }
    line = readLine(strippingNewline: true)
}
