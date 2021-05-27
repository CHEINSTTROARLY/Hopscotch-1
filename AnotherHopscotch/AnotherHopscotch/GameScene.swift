//
//  GameScene.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import SpriteKit
import GameplayKit

var textual =
"""
run|print(int(1).inc)|_ind(0)
"""
//struct|Foo|_ind(0)
//var|foo|=|0.int|_ind(1)
//run|print(Int())|_ind(0)
//run|print(Foo().foo)|_ind(0)



//var textual =
//"""
//run|print(123.int.rev)|_ind(0)
//run|print(123.int.palin)|_ind(0)
//run|print(101.bigint.isPrime)|_ind(0)
//run|print(101.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//"""

//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(11111111111111111111111.bigint.isPrime)|_ind(0)
//run|print(11001011011100111110110010101001111111001110101000010110001101100010011001111111111101001101100101101011011011001111001110011110011011011010110100110110010111111111110011001000110110001101000010101110011111110010101001101111100111011010011.bigint.isPrime)|_ind(0)
//run|print(6660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001.bigint.isPrime)|_ind(0)

// FIB
//var textual =
//"""
//var|one|=|0.bigint|_ind(0)
//var|two|=|1.bigint|_ind(0)
//while|true|_ind(0)
//var|sum|=|$one.add($two)|_ind(1)
//run|print($sum)|_ind(1)
//var|one|=|$two|_ind(1)
//var|two|=|$sum|_ind(1)
//"""

//var textual =
//"""
//func|doThis|_ind(0)
//return|$0|_ind(1)
//run|print(print())|_ind(0)
//run|print(doThis())|_ind(0)
//run|print(doThis(1))|_ind(0)
//run|print(doThis(2))|_ind(0)
//run|print(doThis(3, 1))|_ind(0)
//var|foo|=|0.int|_ind(0)
//repeat|10|times|_ind(0)
//run|print(0, 1)|_ind(1)
//for|i|in|range(1.int,7.int)|_ind(0)
//run|print(i.get)|_ind(1)
//for|i|in|hello|_ind(0)
//run|print(i.get)|_ind(1)
//while|true|_ind(0)
//run|set(foo,$foo.add(1.int))|_ind(1)
//run|print($foo)|_ind(1)
//if|get(foo).equals(10.int)|_ind(1)
//break|_ind(2)
//none|_ind(0)
//run|foo += 1|_ind(0)
//if|true|_ind(0)
//run|print(Hello World!)|_ind(1)
//else|true|_ind(0)
//run|print(Goodbye Cruel World?)|_ind(1)
//none|_ind(0)
//if|foo == 1|_ind(0)
//if|(5 + 5 + 5) == true|_ind(1)
//if|(5 + 5 + 5) == true|_ind(2)
//break|_ind(3)
//if|(5 + 5 + 5) == true|_ind(3)
//if|(5 + 10 + 5) == true|_ind(4)
//var|foobar|=|10|_ind(0)
//var|foobar|=|10|_ind(0)
//for|i|in|7|_ind(0)
//var|doThis|=|1101000|_ind(1)
//if|Bool.random()|_ind(1)
//continue|_ind(2)
//run|print(Hello World!)|_ind(1)
//
//struct|Foo|_ind(0)
//func|doThis|_ind(1)
//run|foo += 1|_ind(2)
//return|true|_ind(2)
//class|Foo|_ind(0)
//enum|Foo|_ind(0)
//case|foo|_ind(1)
//case|bar|_ind(1)
//"""

class GameScene: SKScene {
    
    var superNode = SKNode()
    
    var statements: [Block] = [
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 10 + 5) == true"))),
        (Block.Make(.createValue(name: "foobar", setTo: "10"))),
        (Block.Make(.createValue(name: "foobar", setTo: "10"))),
        (Block.Make(.repeatNTimes(n: "100")))
    ]
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        addChild(superNode)
        
//        for i in 1...10000 {
//            print(i)
//        }
        
        statements = []
        let woo = textual.parse()
        print("Finished Parsing:")
        print(woo)

        for i in woo {
            let wo = Block.Make(i.0)
            statements.append(wo)
            wo.indentions = i.1
        }
        
        print("Finished Turning into Blocks:")
        
        for i in 0..<statements.count {
            let io = statements[i]
            superNode.addChild(io)
            io.position.x = 100 + (io.calculateAccumulatedFrame().width/2)
            io.position.y = frame.height - 200 + (CGFloat(i) * -113) + (io.calculateAccumulatedFrame().height/2)
            io.item = i
            if io.indentions > 0 {
                io.setIndent(io.indentions)
            }
        }
        
        print("Loaded content.:")
        
        // RUN BUTTON
        let wo = VeryMagicShape.Make(.init(width: 70, height: 50), color: .black, corner: 10)
        addChild(wo)
        wo.position.x = frame.width - 95
        wo.position.y = frame.height - 75
        wo.zPosition = 100
        let wooo = Label.init(text: "Run!")
        wooo.fontSize = 32
        wooo.verticalAlignmentMode = .center
        wo.addChild(wooo)
        wo.name = "Run"
    }
    
    var selection: SKShapeNode!
    var selected: Block!
    var editing: VeryMagicShape!
        
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        
        selection?.removeFromParent()
        selection = nil
        selected = nil
        editing = nil
        
        let nodesAtLocation = nodes(at: location)
        
        if let _ = nodesAtLocation.first(where: { $0.name == "Run" }) {
            print("RUN THE CODE")
            runProgram()
        } else if let tappedBlock = nodesAtLocation.first(where: { $0 is VeryMagicShape }) as? VeryMagicShape {
            // Select an Editing Panel
            editing = tappedBlock
            selection = tappedBlock.select()
        } else if let tappedBlock = nodesAtLocation.first(where: { $0 is Block }) as? Block {
            // Normally Select a Block
            selection?.removeFromParent()
            selected = tappedBlock
            selection = tappedBlock.select()
            superNode.addChild(selection)
        }
    }
    
    var holdingKeys: Set<Int> = []
    
    override func keyDown(with event: NSEvent) {
        _keyPressed(event)
    }
    
    override func keyUp(with event: NSEvent) {
        holdingKeys.remove(Int(event.keyCode))
    }
    
    override func mouseDragged(with event: NSEvent) {
        superNode.position.y -= (event.deltaY)*2
        superNode.position.x += (event.deltaX)*2
        
        let ok = superNode.calculateAccumulatedFrame()
        let okok = frame.size
        let maxWIDTH = ok.size.width
        let maxHEIGHT = ok.size.height
        //let massiveHeight = 200 + ok.height - okok.height
        //let massiveWidth = 200 + ok.width - okok.width
        
        if superNode.position.x >= 0 {
            superNode.position.x = 0
        } else if superNode.position.x < 800 - maxWIDTH {
            if maxWIDTH > 800 {
                superNode.position.x = 800 - maxWIDTH
            } else {
                superNode.position.x = 0
            }
        }
        
        if superNode.position.y <= 0 {
            superNode.position.y = 0
        } else if superNode.position.y > maxHEIGHT - 800 {
            if maxHEIGHT > 800 {
                superNode.position.y = maxHEIGHT - 800
            } else {
                superNode.position.y = 0
            }
        }
    }
    
    func runProgram() {
        print("__________")
        print("PROGRAM:")
        var t = ""
        for i in statements {
            var textual = ""
            for j in i.labels {
                if j.text == "" {
                    textual += " |"
                } else {
                    textual += (j.text ?? " ") + "|"
                }
            }
            textual += "_ind(\(i.indentions))"
            print(textual)
            t += textual + "\n"
        }
        print("__________")
        
        
        let superParse = t.parse()
        superParse.runProgram()
    }
    
}
