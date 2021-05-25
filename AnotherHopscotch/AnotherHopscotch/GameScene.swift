//
//  GameScene.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    var statements: [Block] = [
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 10 + 5) == true"))),
        (Block.Make(.createValue(name: "foobar", setTo: 10)))
    ]
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        for i in 0..<statements.count {
            let io = statements[i]
            addChild(io)
            io.position.x = 100 + (io.calculateAccumulatedFrame().width/2)
            io.position.y = frame.height - 200 + (CGFloat(i) * -113) + (io.calculateAccumulatedFrame().height/2)
            io.item = i
        }
    }
    
    var selection: SKShapeNode!
    var selected: Block!
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        
        if let tappedBlock = nodes(at: location).first(where: { $0 is VeryMagicShape }) as? VeryMagicShape {
            selection?.removeFromParent()
            selected = nil
            
            tappedBlock.label.text! += "å"
            let updatedBox = tappedBlock.repaintBox()
            selection = updatedBox.select()
            statements[updatedBox.superBox.item] = updatedBox.superBox
            
        } else if let tappedBlock = nodes(at: location).first(where: { $0 is Block }) as? Block {
            selection?.removeFromParent()
            selected = tappedBlock
            selection = tappedBlock.select()
            addChild(selection)
            
        } else {
            selection?.removeFromParent()
            selection = nil
        }
    }
    
    var holdingKeys: Set<Int> = []
    
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        holdingKeys.insert(Int(event.keyCode))
        
        foo: if holdingKeys.holdingKeys([.tab, .q]) {
            if selected.indentions == 0 { break foo }
            selected.indent(-1)
            selection.position.x.indent(-1)
        } else if event.tappedKey(.tab) {
            selected.indent(1)
            selection.position.x.indent(1)
        }
    }
    
    override func keyUp(with event: NSEvent) {
        holdingKeys.remove(Int(event.keyCode))
    }

}


