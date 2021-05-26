//
//  ResolveFunctions.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation


extension Array where Element == String {
    func backToTuple() -> String {
        var reduction = reduce("") { $0 + $1 + "," }
        while reduction.hasSuffix(",") {
            reduction.removeLast()
        }
        return "(" + reduction + ")"
    }
}

extension String {
    
    func resolveDot() -> String {
        // This line may be a bugfix for void param functions...
        if !self.contains(".") { return self }
        
        //print("start:", self)
        var p: [(String,[String])] = [("",[""])]
        
        var o = 0
        for i in self {
            
            if i == "(" { o += 1; if o == 1 { continue } }
            if i == ")" { o -= 1; if o == 0 { continue } }
            
            if o == 0 {
                if i == "." {
                    p.append(("",[""]))
                } else {
                    p[p.count-1].0.append(i)
                }
                continue
            }
            
            if i == ",", o == 1 {
                p[p.count-1].1.append("")
                continue
            }
            p[p.count-1].1[p[p.count-1].1.count - 1].append(i)
            
        }
        
        let po = p.removeFirst()
        
        if p.isEmpty {
           p = [("",[""])]
        }
        
        if po.1[0].isEmpty {
            p[0].1 = [po.0] + p[0].1
        } else {
            p[0].1 = [po.0 + po.1.backToTuple()] + p[0].1
        }
        
        while p.count > 1 {
            let po = p.removeFirst()
            p[0].1 = [po.0 + po.1.backToTuple()] + p[0].1
        }
        
        var end = p[0].0 + p[0].1.backToTuple()
        
        while end.hasPrefix("(") {
            end.removeFirst()
            end.removeLast()
        }
        
        //print("end:", end)
        
        return end
    }
    
//    func resolveTuple() -> [String] {
//        var functionName = self.replacingAll(matching: (#"(?<=\().*(?=\))"#), with: "")
//        functionName.removeLast(2)
//
//        var params: [String] = [""]
//        var open = 0
//        for i in self {
//            if i == "(" { open += 1; if open == 1 { continue } }
//            if i == ")" { open -= 1; if open == 0 { continue } }
//
//
//            if open > 0 {
//                if i == " ", params.last?.isEmpty == true { continue }
//                if i == ",", open == 1 {
//                    params.append("")
//                    continue
//                }
//                params[params.count-1].append(i)
//            }
//        }
//        //print("-", functionName, "-", params)
//
//        return params
//    }
    
    func resolveTrueFunction() -> StackCode {
        
        if !self.contains("(") {
            return self.parseLine()// .literal(.str, self)
        }
        
        var functionName = self.replacingAll(matching: (#"(?<=\().*(?=\))"#), with: "")
        functionName.removeLast(2)
        
        var params: [String] = [""]
        var open = 0
        for i in self {
            if i == "(" { open += 1; if open == 1 { continue } }
            if i == ")" { open -= 1; if open == 0 { continue } }
            
            
            if open > 0 {
                if i == " ", params.last?.isEmpty == true { continue }
                if i == ",", open == 1 {
                    params.append("")
                    continue
                }
                params[params.count-1].append(i)
            }
        }
        //print("-", functionName, "-", params)
        
        return .goToFunction(name: functionName, parameters: params.map { $0.parseLine() })
    }
    
    func resolveFunction() -> StackCode {
        return self.resolveDot().resolveTrueFunction()
    }
    
}
