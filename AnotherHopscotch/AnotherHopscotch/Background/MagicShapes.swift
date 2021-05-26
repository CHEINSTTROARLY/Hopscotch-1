//
//  MagicShapes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit


// Any Colored Block Shape
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

// The White Editing SHAPE (contains a text)
class VeryMagicShape: MagicShape {
    var label: Label!
    
    func repaintBox() -> (VeryMagicShape, Block) {
        let updatedBox = VeryMagicShape.Make(label.paddedSizeOfLabel(), color: .white, corner: 20)
        parent?.addChild(updatedBox)
        removeFromParent()
        updatedBox.label = label
        updatedBox.position.x = (updatedBox.label.frame.size.width/2)
        return (updatedBox, updatedBox.label.superBox.repaintBox())
    }
}




class Block: SKNode {
    static var blocksThatExist = 0
    deinit {
        Self.blocksThatExist -= 1
        //print("Goodbyem now there are: \(Self.blocksThatExist)")
    }
    
    
    var shape: MagicShape!
    var item = 0
    var labels: [Label] = []
    
    var indentions: Int = 0
    func indent(_ int: Int) {
        indentions += int
        position.x.indent(int)
    }
    func setIndent(_ int: Int) {
        position.x.indent(int)
    }
    
    static func Make(_ this: BlockTypes) -> Block {
        Self.blocksThatExist += 1
        let shape = Block()// Block(color: .black, size: .init(width: 100, height: 100))
        let magicColor = shape.attributes(this, fromBox: shape)
        
        let blocko = MagicShape.Make(.init(width: 100 + shape.calculateAccumulatedFrame().size.width, height: 100), color: magicColor)
        shape.addChild(blocko)
        shape.shape = blocko
        
        return shape
    }
    
    @discardableResult
    func attributes(_ this: BlockTypes, fromBox: Block) -> NSColor {
        switch this {
        case let .createValue(name: n, setTo: s): return self.attributes(.basic([.c("var"), .edit(n), .c("="), .edit(String(s))]), fromBox: fromBox)
        case let .ifStatement(bool: b): return self.attributes(.basic([.c("if"), .edit(b)]), fromBox: fromBox)
        case .elseStatement: return self.attributes(.basic([.c("else")]), fromBox: fromBox)
        case let .elif(bool: b): return self.attributes(.basic([.c("elif"), .edit(b)]), fromBox: fromBox)
        case let .whileStatement(bool: b): return self.attributes(.basic([.c("while"), .edit(b)]), fromBox: fromBox)
        case let .repeatNTimes(n: n): return self.attributes(.basic([.c("repeat"), .edit(String(n)), .c("times")]), fromBox: fromBox)
        case let .iterate(this: t, over: o): return self.attributes(.basic([.c("for"), .edit(t), .c("in"), .edit(o)]), fromBox: fromBox)
        case let .run(n: n): return self.attributes(.basic([.c("run"), .edit(n)]), fromBox: fromBox)
        
        case let .function(name: n): return self.attributes(.basic([.c("func"), .edit(n)]), fromBox: fromBox)
        case let .structure(name: n): return self.attributes(.basic([.c("struct"), .edit(n)]), fromBox: fromBox)
        case let .classo(name: n): return self.attributes(.basic([.c("class"), .edit(n)]), fromBox: fromBox)
        case let .enumeration(name: n): return self.attributes(.basic([.c("enum"), .edit(n)]), fromBox: fromBox)
        case let .caseThing(name: n): return self.attributes(.basic([.c("case"), .edit(n)]), fromBox: fromBox)
        case let .returnThing(name: n): return self.attributes(.basic([.c("return"), .edit(n)]), fromBox: fromBox)
        case .breaker: return self.attributes(.basic([.c("break")]), fromBox: fromBox)
        case .continuer: return self.attributes(.basic([.c("continue")]), fromBox: fromBox)
        case .none: return self.attributes(.basic([.c("none")]), fromBox: fromBox)
            
        case let .copy(these):
            let groupNode = SKNode()
            
            var soMaxX: CGFloat = -50
            for text in these {
                let foo = text
                foo.superBox = fromBox
                    
                foo.removeFromParent()
                groupNode.addChild(foo)
                foo.position.x = soMaxX + 50
                soMaxX = foo.frame.maxX
                labels.append(foo)
            }
            
            addChild(groupNode)
            let groupWidth = groupNode.calculateAccumulatedFrame().width
            groupNode.position.y = self.frame.midY
            //self.size.width += groupWidth
            groupNode.position.x = self.frame.midX - (groupWidth/2)
            
            // Choose color of block
            if !these[0].editable {
                return these[0].text?.color() ?? .black
            } else {
                return .white // unknown starts with a text block!?
            }
            
        case let .basic(these):
            let groupNode = SKNode()
            
            var soMaxX: CGFloat = -50
            for text in these {
                let foo = Label.Make(text, fromBox: self)
                groupNode.addChild(foo)
                foo.position.x = soMaxX + 50
                soMaxX = foo.frame.maxX
                labels.append(foo)
            }
            
            addChild(groupNode)
            let groupWidth = groupNode.calculateAccumulatedFrame().width
            groupNode.position.y = self.frame.midY
            //self.size.width += groupWidth
            groupNode.position.x = self.frame.midX - (groupWidth/2)
            
            // Choose color of block
            switch these[0] {
            case let .c(this): return this.color()
            default: return .white // unknown starts with a text block!?
            }
            
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
        let updatedBox = Block.Make(.copy(labels))
        
        parent?.addChild(updatedBox)
        removeFromParent()
        updatedBox.position.y = position.y
        updatedBox.position.x = calculateAccumulatedFrame().minX + (updatedBox.calculateAccumulatedFrame().width/2)
        updatedBox.item = item
        updatedBox.indentions = indentions
        return updatedBox
    }
    
}

class Label: SKLabelNode {
    var editable: Bool = false
    var superBox: Block!
    
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
            foo.canEdit(fromBox: fromBox)
            return foo
        }
    }
    
    func paddedSizeOfLabel() -> CGSize {
        return frame.size.padding()
    }
    
    func canEdit(fromBox: Block) {
        editable = true
        
        let woah = VeryMagicShape.Make(paddedSizeOfLabel(), color: .white, corner: 20)
        woah.zPosition = -1
        woah.position.y = position.y
        woah.position.x = position.x + (frame.size.width/2)
        woah.label = self
        addChild(woah)
        superBox = fromBox
    }
}

