//
//  exec.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

@discardableResult
func exec(_ this: String) -> Value {
    return [this.parseLine()].run()
    //return [this.resolveFunction()].run()
}

extension String {
    func parseLine() -> StackCode {
        let parsing = self.split(separator: " ").map {  String($0) }
        
//        if parsing.count > 2, parsing.contains("=") {
//            let foo = self.splitFirst(from: "=")
//            return "set(\(foo.0),\(foo.1))".parseLine()
//        }
        
        if hasPrefix("$"), !contains(".") {
            var foo = self; foo.removeFirst(); return "get(\(foo))".parseLine()
        }
        
        //if let wow = Main.values[self] {
          //  return .literal(wow.magicType, wow.value)
        //} else
        
        if self.contains("(") || self.contains(".") {
            return self.resolveFunction()
            //return exec(self)
        } else {
            return .literal(Value(.str, self))
        }
    }
}
