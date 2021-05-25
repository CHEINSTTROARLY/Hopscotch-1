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
run|foo += 1|_ind(0)
if| |_ind(0)
if| |_ind(0)
if|(5 + 5 + 5) == true|_ind(0)
if|(5 + 5 + 5) == true|_ind(1)
if|(5 + 5 + 5) == true|_ind(1)
if|(5 + 10 + 5) == true|_ind(0)
var|foobar|=|10|_ind(0)
var|foobar|=|10|_ind(0)
for|i|in|7|_ind(0)
var|doThis|=|1101000|_ind(1)
"""

class GameScene: SKScene {
    
    var superNode = SKNode()
    
    var statements: [Block] = [
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 10 + 5) == true"))),
        (Block.Make(.createValue(name: "foobar", setTo: "10"))),
        (Block.Make(.createValue(name: "foobar", setTo: "10"))),
    ]
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        addChild(superNode)
        
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
        
        if let tappedBlock = nodes(at: location).first(where: { $0 is VeryMagicShape }) as? VeryMagicShape {
            // Select an Editing Panel
            editing = tappedBlock
            selection = tappedBlock.select()
        } else if let tappedBlock = nodes(at: location).first(where: { $0 is Block }) as? Block {
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
        superNode.position.y -= event.deltaY
    }

}


