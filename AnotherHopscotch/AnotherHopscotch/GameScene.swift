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
        (Block.Make(.createValue(name: "foobar", setTo: 10))),
        (Block.Make(.createValue(name: "foobar", setTo: 10))),
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
    var editing: VeryMagicShape!
        
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        
        selection?.removeFromParent()
        selection = nil
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
            addChild(selection)
        }
    }
    
    var holdingKeys: Set<Int> = []
    
    override func keyDown(with event: NSEvent) {
        //if holdingKeys.contains(Int(event.keyCode)) { return }
        //print(event.keyCode)
        holdingKeys.insert(Int(event.keyCode))
        
        if let selected = selected {
            foo: if event.tappedKey(.leftArrow) {
                if selected.indentions == 0 { break foo }
                selected.indent(-1)
                selection.position.x.indent(-1)
            } else if event.tappedKey(.rightArrow) {
                selected.indent(1)
                selection.position.x.indent(1)
            }
        }
        
        if let editing = editing {
            
            if event.tappedKey(.delete) {
                
                var removeLastN = 1
                
                if event.modifierFlags.contains(.command) {
                    editing.label.text = ""
                    let (updatedBox, superBox) = editing.repaintBox()
                    self.editing = updatedBox
                    selection = updatedBox.select()
                    statements[superBox.item] = superBox
                    return
                } else if event.modifierFlags.contains(.option) {
                    var foo = 0
                    _ = editing.label.text?.map { i in
                        if i == " " { foo = 1 } else { foo += 1 }
                    }
                    removeLastN = foo
                }
                
                if editing.label.text?.isEmpty == false {
                    editing.label.text?.removeLast(removeLastN)
                    let (updatedBox, superBox) = editing.repaintBox()
                    self.editing = updatedBox
                    selection = updatedBox.select()
                    statements[superBox.item] = superBox
                }
                
            } else {
                
                if event.modifierFlags.contains(.command) { return }
                if event.modifierFlags.contains(.control) { return }
                
                if event.modifierFlags.contains(.option) {
                    if event.modifierFlags.contains(.shift) || event.modifierFlags.contains(.capsLock) {
                        if case let str = event.keyString(.optionShift), str != "" {
                            editing.label.text! += str
                        } else { return }
                    } else {
                        if case let str = event.keyString(.option), str != "" {
                            editing.label.text! += str
                        } else { return }
                    }
                } else {
                    if event.modifierFlags.contains(.shift) || event.modifierFlags.contains(.capsLock) {
                        if case let str = event.keyString(.shift), str != "" {
                            editing.label.text! += str
                        } else { return }
                    } else {
                        if case let str = event.keyString(.none), str != "" {
                            editing.label.text! += str
                        } else { return }
                    }
                }
                
                let (updatedBox, superBox) = editing.repaintBox()
                self.editing = updatedBox
                selection = updatedBox.select()
                statements[superBox.item] = superBox
            }
            
        }
        
        
    }
    
    override func keyUp(with event: NSEvent) {
        holdingKeys.remove(Int(event.keyCode))
    }

}


