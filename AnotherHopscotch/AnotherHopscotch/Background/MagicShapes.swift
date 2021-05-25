//
//  MagicShapes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit


class MagicShape: SKShapeNode {
    static func Make(_ from: CGSize, color: NSColor = .black, corner: CGFloat = 10) -> Self {
        let blocko = Self(rectOf: from, cornerRadius: corner)
        blocko.fillColor = color
        blocko.strokeColor = color
        return blocko
    }
    
    func select() -> MagicShape {
        let selection = MagicShape.Make(frame.size.padding(10), color: .white, corner: 25)
        selection.alpha = 0.7
        selection.zPosition = -0.5
        addChild(selection)
        return selection
    }
    
    
}
class VeryMagicShape: MagicShape {
    var label: Label!
    var superBox: Block!
    
    func repaintBox() -> VeryMagicShape {
        let updatedBox = VeryMagicShape.Make(label.paddedSizeOfLabel(), color: .white, corner: 20)
        parent?.addChild(updatedBox)
        removeFromParent()
        updatedBox.label = label
        updatedBox.position.x = (updatedBox.label.frame.size.width/2)
        updatedBox.superBox = superBox.repaintBox()
        return updatedBox
    }
}




class Block: SKNode {
    var shape: SKShapeNode!
    var item = 0
    
    var indentions: Int = 0
    func indent(_ int: Int) {
        indentions += int
        position.x.indent(int)
    }
    
    static func Make(_ this: BlockTypes) -> Block {
        let shape = Block()// Block(color: .black, size: .init(width: 100, height: 100))
        let magicColor = shape.attributes(this)
        
        let blocko = MagicShape.Make(.init(width: 100 + shape.calculateAccumulatedFrame().size.width, height: 100), color: magicColor)
        shape.addChild(blocko)
        shape.shape = blocko
        
        return shape
    }
    
    @discardableResult
    func attributes(_ this: BlockTypes) -> NSColor {
        switch this {
        case let .createValue(name: n, setTo: s):
            self.attributes(.basic([.c("var"), .edit(n), .c("="), .edit(String(s))]))
            return .init(red: 220.0/255.0, green: 194.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            
        case let .ifStatement(bool: b):
            self.attributes(.basic([.c("if"), .edit(b)]))
            return .init(red: 71.0/255.0, green: 174.0/255.0, blue: 1.0, alpha: 1.0)
        
        case let .basic(these):
            let groupNode = SKNode()
            
            var soMaxX: CGFloat = -50
            for text in these {
                let foo = Label.Make(text, fromBox: self)
                groupNode.addChild(foo)
                foo.position.x = soMaxX + 50
                soMaxX = foo.frame.maxX
            }
            
            addChild(groupNode)
            let groupWidth = groupNode.calculateAccumulatedFrame().width
            groupNode.position.y = self.frame.midY
            //self.size.width += groupWidth
            groupNode.position.x = self.frame.midX - (groupWidth/2)
            return .black
        }
    }
    
    func select() -> MagicShape {
        let woah = shape.fillColor.withAlphaComponent(0.3)
        let selection = MagicShape.Make(shape.frame.size.padding(), color: woah, corner: 20)
        
        selection.zPosition = -1
        selection.position = position
        return selection
    }
    
    func repaintBox() -> Block {
        let updatedBox = Block.Make(.basic([.edit("foo")]))// VeryMagicShape.Make(label.paddedSizeOfLabel(), color: .white, corner: 20)
        parent?.addChild(updatedBox)
        removeFromParent()
        updatedBox.position.y = position.y
        updatedBox.position.x = calculateAccumulatedFrame().minX + (updatedBox.calculateAccumulatedFrame().width/2)
        updatedBox.item = item
        return updatedBox
    }
    
}

class Label: SKLabelNode {
    
    static func Make(_ text: BlockTypes.EditType, fromBox: Block!) -> Label {
        switch text {
        case let .c(text):
            let foo = Label(text: text)
            foo.verticalAlignmentMode = .center
            foo.horizontalAlignmentMode = .left
            foo.fontColor = .white
            foo.fontSize = 50
            return foo
        case let .edit(text):
            let foo = Label(text: text)
            foo.verticalAlignmentMode = .center
            foo.horizontalAlignmentMode = .left
            foo.fontColor = .black
            foo.fontSize = 50
            foo.zPosition = 2
            
            let woah = VeryMagicShape.Make(foo.paddedSizeOfLabel(), color: .white, corner: 20)
            woah.zPosition = -1
            woah.position.y = foo.position.y
            woah.position.x = foo.position.x + (foo.frame.size.width/2)
            woah.label = foo
            foo.addChild(woah)
            woah.superBox = fromBox
            
            return foo
        }
    }
    
    func paddedSizeOfLabel() -> CGSize {
        return frame.size.padding()
    }
    
}

