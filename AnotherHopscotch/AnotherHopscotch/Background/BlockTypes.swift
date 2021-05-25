//
//  BlockTypes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

enum BlockTypes {
    case createValue(name: String, setTo: Int)
    case ifStatement(bool: String)
    
    case basic(_ these: [EditType])
    enum EditType {
        case c(String)
        case edit(String)
    }
}

