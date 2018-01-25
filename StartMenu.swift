//
//  StartMenu.swift
//  
//
//  Created by Mitchell Walters on 1/24/18.
//

import Foundation
import SpriteKit


class StartMenu: SKScene {
    
    var play_button = SKLabelNode(text: "PLAY")
    
    
    var title = SKLabelNode(text: "PUSHTAP")
    
    override func didMove(to view: SKView) {
        print("start menu")
        self.backgroundColor = SKColor.black
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = SCREEN_SIZE
        
        play_button.position = CGPoint(x: 0, y: -100)
        play_button.fontColor = SKColor.red
        play_button.fontSize = 100
        play_button.name = "play"
        addChild(play_button)
        
        title.position = CGPoint(x: 0, y: 325)
        title.color = SKColor.purple
        title.fontSize = 150
        
        addChild(title)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if name == "play" {
                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
                    self.view?.presentScene(DifficultySelection(), transition: reveal)
                }
                
            }
        }
    }
    
}
