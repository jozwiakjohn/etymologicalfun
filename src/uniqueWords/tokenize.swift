//
//  tokenize.swift
//  analyzeText
//
//  Created by john jozwiak on 2019-05-13.
//  Copyright © 2019 john jozwiak. All rights reserved.
//

func examineLine( _ s : String ) -> [String] {
    let t =
        s.components(separatedBy: " ")
         .filter { s in s.count > 0 }
         .map { s in s.replacingOccurrences(of: #"[,.;:]"#,   with: "", options: .regularExpression)}
    return t
}
