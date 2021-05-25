//
//  KeyPressed.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit

extension GameScene {
    func _keyPressed(_ event: NSEvent) {
        //if holdingKeys.contains(Int(event.keyCode)) { return }
        //print(event.keyCode)
        holdingKeys.insert(Int(event.keyCode))
        
        if event.tappedKey(.spacebar), editing == nil, selected == nil {
            print("__________")
            print("PROGRAM:")
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
            }
            print("__________")
        }
        
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
}
