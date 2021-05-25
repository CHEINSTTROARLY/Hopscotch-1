//
//  ParseString.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

extension String {
    
    func parse() -> [(BlockTypes, indents: Int)] {
        var hello: [(BlockTypes, Int)] = []
        
        for i in self.split(separator: "\n") {
            var line = i.split(separator: "|").map { String($0) }
            
            if line.isEmpty { continue }
            var indento = line.removeLast()
            var ind = 0
            if indento.hasPrefix("_ind(") == true {
                indento.removeFirst(5); indento.removeLast()
                ind = Int(indento)!
            }
            
            if line[0] == "var" {
                hello.append((.createValue(name: line[1], setTo: line[3]), ind))
            } else if line[0] == "if" {
                hello.append((.ifStatement(bool: line[1]),ind))
            } else if line[0] == "else" {
                hello.append((.elseStatement,ind))
            } else if line[0] == "elif" {
                hello.append((.elif(bool: line[1]),ind))
            } else if line[0] == "for" {
                hello.append((.iterate(this: line[1], over: line[3]),ind))
            } else if line[0] == "while" {
                hello.append((.whileStatement(bool: line[1]),ind))
            } else if line[0] == "while" {
                hello.append((.repeatNTimes(n: line[1]),ind))
            } else if line[0] == "run" {
                hello.append((.run(n: line[1]),ind))
            }
            
        }
        
        return hello
    }
    
    
}
