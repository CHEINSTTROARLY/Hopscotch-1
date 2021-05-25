//
//  GameScene.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import SpriteKit
import GameplayKit

extension NSEvent {
    enum KeyCodes: Int {
        case tab = 48
        case q = 12
    }
    func tappedKey(_ n: KeyCodes) -> Bool {
        return keyCode == n.rawValue
    }
}
extension Set where Element == Int {
    func holdingKeys(_ these: [NSEvent.KeyCodes]) -> Bool {
        return self.intersection(these.map { $0.rawValue }).count == these.count
    }
}

class GameScene: SKScene {
    
    let statements: [Block] = [
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 5 + 5) == true"))),
        (Block.Make(.ifStatement(bool: "(5 + 10 + 5) == true"))),
        (Block.Make(.createValue(name: "foobar", setTo: 10)))
    ]
    
    override func didMove(to view: SKView) {
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
        if let tappedBlock = nodes(at: location).first(where: { $0 is Block }) as? Block {
            selection?.removeFromParent()
            
            selection = MagicShape.Make(tappedBlock.shape.frame.size.padding(), color: .white, corner: 20)
            selected = tappedBlock
            
            //selection = SKSpriteNode.init(color: .gray, size: tappedBlock.shape.frame.size.padding())
            
            selection.zPosition = -1
            selection.position = tappedBlock.position
            addChild(selection)
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

class MagicShape: SKShapeNode {
    static func Make(_ from: CGSize, color: NSColor = .black, corner: CGFloat = 10) -> MagicShape {
        let blocko = MagicShape(rectOf: from, cornerRadius: corner)
        blocko.fillColor = color
        blocko.strokeColor = color
        return blocko
    }
}

class Block: SKNode {
    var shape: SKShapeNode!
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
            self.attributes(.basic(["var", n, "=", String(s)]))
            return .init(red: 220.0/255.0, green: 194.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            
        case let .ifStatement(bool: b):
            self.attributes(.basic(["if", b]))
            return .init(red: 71.0/255.0, green: 174.0/255.0, blue: 1.0, alpha: 1.0)
        
        case let .basic(these):
            let groupNode = SKNode()
            
            var soMaxX: CGFloat = -50
            for text in these {
                let foo = Label.Make(text)
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
}

class Label: SKLabelNode {
    static func Make(_ text: String) -> Label {
        let foo = Label(text: text)
        foo.verticalAlignmentMode = .center
        foo.horizontalAlignmentMode = .left
        foo.fontColor = .white
        foo.fontSize = 50
        return foo
    }
    
}


enum BlockTypes {
    case createValue(name: String, setTo: Int)
    case ifStatement(bool: String)
    
    case basic(_ these: [String])
}


extension CGSize {
    func padding() -> Self {
        return .init(width: width + 20, height: height + 20)
    }
}
extension CGPoint {
    mutating func minusPadding() {
        x -= 10; y -= 10
    }
}
extension CGFloat {
    mutating func indent(_ n: Int) {
        self += CGFloat(n) * 50
    }
}
