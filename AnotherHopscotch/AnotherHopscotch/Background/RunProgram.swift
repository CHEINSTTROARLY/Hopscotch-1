//
//  RunProgram.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

func reset() {
    Main.functions = [:]
    Main.values = [:]
    Precompile.go()
}

extension Array where Element == (BlockTypes, indents: Int) {
    func runProgram() {
        print("Precompiling...")
        reset()
        
        print("Running Program!")
        print("__________")
        var values: [String:String] = [:]
        
        var line = 0
        var currentIndent = 0
        for i in self {
            line += 1
            
            if i.indents > currentIndent {
                //print("Warning on Line \(line) - This line is too indented.")
                continue
            }
            
            switch i.0 {
            case let .createValue(name: nameOfValue, setTo: setValueTo):
                values[nameOfValue] = setValueTo
            case let .run(n: code):
                exec(code)
                
            case let .ifStatement(bool: booleanExpression):
                let expression = exec(booleanExpression)
                //print("IF RESULTS", expression)
                if expression == true {
                    currentIndent += 1
                } else if expression == false {
                    
                } else {
                    print("WARNING on line \(line), not a boolean result.")
                }
            case .elseStatement:
                if currentIndent == i.indents {
                    currentIndent += 1
                }
            
            case .none: continue
                
            default:
                print("Haven't coded for \(i.0)")
                continue
            }
            
        }
        
        print("__________")
        print("End of Program.")
        
    }
}
