//
//  GameScene.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import SpriteKit
import GameplayKit

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
