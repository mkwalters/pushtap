//
//  DifficultySelection.swift
//  PushTap
//
//  Created by Mitchell Walters on 1/24/18.
//  Copyright © 2018 Mitchell Walters. All rights reserved.
//

import Foundation
import SpriteKit


class DifficultySelection: SKScene {
    
    
    var easy = SKLabelNode(text: "easy")
    var medium = SKLabelNode(text: "medium")
    var hard = SKLabelNode(text: "hard")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = SCREEN_SIZE
        
        easy.position = CGPoint(x: 0, y: 200)
        easy.fontSize = 100
        easy.fontColor = SKColor.blue
        easy.name = "easy"
        addChild(easy)
        
        medium.position = CGPoint(x: 0, y: 0)
        medium.fontSize = 100
        medium.fontColor = SKColor.purple
        medium.name = "medium"
        addChild(medium)
        
        hard.position = CGPoint(x: 0, y: -200)
        hard.fontSize = 100
        hard.fontColor = SKColor.red
        hard.name = "hard"
        addChild(hard)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if name == "easy" {
                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
                    self.view?.presentScene(GameScene(), transition: reveal)
                }
                if name == "medium" {
                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
                    self.view?.presentScene(GameScene(), transition: reveal)
                }
                if name == "hard" {
                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
                    self.view?.presentScene(GameScene(), transition: reveal)
                }
            }
        }
    }
    
}
