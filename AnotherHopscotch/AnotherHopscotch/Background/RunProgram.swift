//
//  RunProgram.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

func reset() {
    Main.reset()
    Precompile.go()
}

typealias CodeList = [(BlockTypes, indents: Int)]
enum SuperEnumCompile {
    case this(BlockTypes, contains: [SuperEnumCompile])
}

extension Array where Element == CodeList.Element {
    func compileEnum(indent: Int = 0) -> [SuperEnumCompile] {
        
        var listo: [SuperEnumCompile] = []
        
        var aboutToAppent: BlockTypes!
        var wiltThouAppend: CodeList = []
        for (cod, ind) in self {
            if ind == indent {
                if let a = aboutToAppent {
                    listo.append(.this(a, contains: wiltThouAppend.compileEnum(indent: indent + 1)))
                }
                wiltThouAppend = []
                aboutToAppent = cod
            }
            if ind > indent {
                wiltThouAppend.append((cod, ind))
            }
            if ind < indent {
                fatalError()
            }
        }
        if let a = aboutToAppent {
            listo.append(.this(a, contains: wiltThouAppend.compileEnum(indent: indent + 1)))
        }
        return listo
        
    }
}
extension Array where Element == SuperEnumCompile {
    
    
    func runEnum() -> (break: Bool, continue: Bool, returnedValue: Value?) {
        var stillCheckIfStatements = true
        
        mainLoop: for i in self {
            switch i {
            case let .this(blockType, contains: enums):
                switch blockType {
                case .none: continue mainLoop
                case .continuer: return (false, true, nil)
                case .breaker: return (true, false, nil)
                case let .returnThing(name: this): return (false, false, exec(this))
                    
                case let .createValue(name: nameOfValue, setTo: setValueTo):
                    Main.values[nameOfValue] = exec(setValueTo)
                    
                case let .run(n: prog):
                    exec(prog)
                
                case let .ifStatement(bool: booleanExpression):
                    stillCheckIfStatements = true
                    
                    let expression = exec(booleanExpression)
                    if expression == true {
                        stillCheckIfStatements = false
                        return enums.runEnum()
                    } else if expression == false {
                        continue
                    } else {
                        print("WARNING \(expression) is not a boolean result.")
                    }
                
                case let .elif(bool: booleanExpression):
                    if !stillCheckIfStatements { continue }
                    
                    let expression = exec(booleanExpression)
                    if expression == true {
                        stillCheckIfStatements = false
                        return enums.runEnum()
                    } else if expression == false {
                        continue
                    } else {
                        print("WARNING \(expression) is not a boolean result.")
                    }
                    
                case .elseStatement:
                    if !stillCheckIfStatements { continue }
                    return enums.runEnum()
                    
                    
                case let .whileStatement(bool: booleanExpression):
                    while exec(booleanExpression) == true {
                        let foo = enums.runEnum()
                        if foo.continue { continue }
                        if foo.break { break }
                    }
                    
                case let .iterate(this: valueName, over: collection):
                    var iterateResults = exec(collection).value
                    
                    // Iterate Bugfix over string
                    if iterateResults is String {
                        iterateResults = "\(iterateResults)".map { $0 }
                    }
                    
                    // Iterate over any Sequence
                    let superMirror = Mirror.init(reflecting: iterateResults)
                    for i in superMirror.children {
                        Main.values[valueName] = Value(.any, i.value)
                        let foo = enums.runEnum()
                        if foo.continue { continue }
                        if foo.break { break }
                    }
                    
                case let .repeatNTimes(n: ntimes):
                    for _ in 1...int(exec(ntimes).value) {
                        let foo = enums.runEnum()
                        if foo.continue { continue }
                        if foo.break { break }
                    }
                    
                case let .function(name: funcName):
                    Main.customFunctions[funcName] = enums
                    
                case let .structure(name: structName):
                    Main.customFunctions[structName] = enums
                    //Main.customFunctions
                    
                default:
                    print("Haven't coded for \(blockType)")
                    
                }
                
                
            }
        }
        return (false, false, nil)
    }
}

extension Array where Element == CodeList.Element {
    func runProgram() {
        print("Precompiling...")
        reset()
        
        print("Compiling Enum Program...")

        
        let compileEnumBetter: [SuperEnumCompile] = self.compileEnum()
        print(compileEnumBetter)
        
        compileEnumBetter.runEnum()
        print("END")
        return
    }
}
