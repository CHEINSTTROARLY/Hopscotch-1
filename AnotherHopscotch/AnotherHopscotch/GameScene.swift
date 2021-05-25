//
//  GameScene.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    let statements: [Block] = [
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
        }
    }
    
    var selection: SKShapeNode!
    var selected: Block!
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        
        if let tappedBlock = nodes(at: location).first(where: { $0 is VeryMagicShape }) as? VeryMagicShape {
            selection?.removeFromParent()
            
            tappedBlock.label.text! += "å"
            
            // Duplicate the White box
            let updatedBox = VeryMagicShape.Make(tappedBlock.label.paddedSizeOfLabel(), color: .white, corner: 20)
            tappedBlock.parent?.addChild(updatedBox)
            tappedBlock.removeFromParent()
            //updatedBox.position = tappedBlock.position
            updatedBox.label = tappedBlock.label
            updatedBox.position.x = (updatedBox.label.frame.size.width/2)
            
            
            selection = MagicShape.Make(updatedBox.frame.size.padding(10), color: .white, corner: 25)
            selection.alpha = 0.7
            selection.zPosition = -0.5
            updatedBox.addChild(selection)
            
            
        } else if let tappedBlock = nodes(at: location).first(where: { $0 is Block }) as? Block {
            selection?.removeFromParent()
            
            let woah = tappedBlock.shape.fillColor.withAlphaComponent(0.3)
            selection = MagicShape.Make(tappedBlock.shape.frame.size.padding(), color: woah, corner: 20)
            
            selected = tappedBlock
            
            selection.zPosition = -1
            selection.position = tappedBlock.position
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


