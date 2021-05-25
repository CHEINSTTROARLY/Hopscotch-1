//
//  BlockTypes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

enum BlockTypes {
    case createValue(name: String, setTo: String)
    case ifStatement(bool: String)
    case elseStatement
    case elif(bool: String)
    case whileStatement(bool: String)
    case repeatNTimes(n: String)
    case iterate(this: String, over: String)
    case run(n: String)
    
    case basic(_ these: [EditType])
    case copy(_ these: [Label])
    
    enum EditType {
        case c(String)
        case edit(String)
    }
}

