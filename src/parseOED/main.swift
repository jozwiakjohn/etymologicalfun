//
//  main.swift
//  parseOED
//
//  Created by john jozwiak on 5/15/19.
//  Copyright © 2019 john jozwiak. All rights reserved.
//
//  This program is meant to read the output of wordsToDefs,
//  where stdin contains lines of the form "word" + " :: " + definition.
//  The contents of the String definition can then be broken down for
//  part of speech, etymology, alternate senses, and whatever else
//  might be returned from wordsToDefs programmatic querying of dictionaries.

import Foundation
import Darwin  //  for exit


var lineNumber    : UInt32  = 0
var line          : String?
var numOrigins    : UInt32  = 0
var uniqWords               = Set<String>()
var outputPython3 : Bool    = CommandLine.arguments.filter { s in s == "python" }.count > 0
var helpRequested : Bool    = CommandLine.arguments.filter { s in s == "help"   }.count > 0

//print("outputP = \(outputPython3)")
if helpRequested {
   print("\n     \(CommandLine.arguments[0])\n\n     reads the output of wordsToDefs, from stdin.")
   print("     Each line should have a word separated from a definition by a double colon.\n")
   print("     If python appears on the commandline, then output is meant to be readable by Python 3.7.3." )
   print("     If help appears on the commandline, this message is produced.\n")
   exit(0)
}

func findStem( _ s : String ) -> String? {
  return nil
}

func matchesRegex( string : String , regex : String ) -> Bool {
   return (nil != string.range( of:regex , options: .regularExpression))
}

func parseOEDLine( _ s : String , whiney : Bool = false ) -> [String] {

   let wordAndDef = s.components(separatedBy: " :: ")
   if wordAndDef.count != 2 {
      if whiney { print("WEIRD : \"\(s)\" -> wordAndDef = \(wordAndDef)") }
      return [wordAndDef[0],"",""]
   }
   let theWord            = wordAndDef[0]
   let theDef             = wordAndDef[1]
   let meaningAndOrigin   = theDef.components(separatedBy: "ORIGIN")
   let theMeaning         = meaningAndOrigin[0]
   var theOrigin : String = ""
   if  meaningAndOrigin.count == 2 {
      theOrigin = meaningAndOrigin[1]
      numOrigins += 1
   } else {
      /* print("WEIRDER : \(meaningAndOrigin)") */
   }
   return [theWord,theOrigin,theMeaning]
}

//  gobble stdin, line by line.

line = readLine(strippingNewline: true)
while (line != nil) {
   let tokenlets = parseOEDLine( line! )
   if (tokenlets.count == 3) {
      let wd = tokenlets[0]
      let wh = tokenlets[1]
      let df = tokenlets[2]
      //print("\n\(tokenlets.count) : \(tokenlets)") // " @ \n\"" + line! + "\"")
      uniqWords.insert( wd )
      print("\n\(wd)\norigin: \(wh)\ndefini: \(df)")
      print("[ " + line! + " ]\n")
   }
   lineNumber += 1

   line = readLine(strippingNewline: true)
}

print("\n\(lineNumber) lines were read; ORIGIN occurred in \(numOrigins) definitions.\nThere were \(uniqWords.count) unique 'words'.")

var entireWords : UInt32 = 0
let uniqWordsInOrder : [ String ] = uniqWords.sorted()
for u in uniqWordsInOrder {
   print(u)
}

let prefixes : [ String ] = uniqWordsInOrder.filter { s in matchesRegex( string: s , regex: "^\\w+-$" ) }
print( "# the number of entries which appear to be prefixes is \(prefixes.count) and the first is \(prefixes[0])" )

let suffixes : [ String ] = uniqWordsInOrder.filter { s in matchesRegex( string: s , regex: "^-\\w+$" ) }
print( "# the number of entries which appear to be suffixes is \(suffixes.count) and the first is \(suffixes[0])" )

let infixes  : [ String ] = uniqWordsInOrder.filter { s in matchesRegex( string: s , regex: "^-\\w+-$" ) }
print( "# the number of entries which appear to be infixes is \(infixes.count) and the first is \(infixes[0])" )
print( infixes )

print( "#  there were \(uniqWordsInOrder.count) words altogether.\n")
