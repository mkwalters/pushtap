//
//  GameScene.swift
//  PushTap
//
//  Created by Mitchell Walters on 1/17/18.
//  Copyright © 2018 Mitchell Walters. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    
    var sensitivity_display = SKLabelNode(text: "0")
    
    
    let left_bar = SKSpriteNode()
    
    
    
    func spawn_rectangles() {
        spawn_rectangle(side: "left")
        spawn_rectangle(side: "right")
    }
    
    func spawn_delay() {
        
        let spawn = SKAction.run({
            
            self.spawn_rectangles()
            
        })
        let delay = SKAction.wait(forDuration: 1.7)
        
        let spawn_delay = SKAction.group([spawn, delay])
        
        let repeat_forever = SKAction.repeatForever(spawn_delay)
        
        run(repeat_forever)
    }
    
    
    func spawn_rectangle(side: String) {
        
        let diceroll = arc4random() % 2
        var color = SKColor.black
        
        if (diceroll == 0) {
            color = SKColor.blue
        } else {
            color = SKColor.red
        }
        
        let drop_down = SKAction.moveBy(x: 0, y: -1500, duration: 3)
        
        let rectangle = SKSpriteNode(color: color, size: CGSize(width: 150, height: 150))
        rectangle.run(drop_down)
        rectangle.position = CGPoint(x: 0, y: 550)
        
        if (side == "left") {
            rectangle.position.x -= 200
        } else {
            rectangle.position.x += 200
        }
        
        addChild(rectangle)

    }
    
    override func didMove(to view: SKView) {
        
        self.view?.isMultipleTouchEnabled = true
        backgroundColor = SKColor.gray
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        left_bar.position = CGPoint(x: 0, y: 0)
        left_bar.color = SKColor.gray
        left_bar.size = CGSize(width: screenWidth, height: 50)
        addChild(left_bar)
        
        
        
        // Get label node from scene and store it for use later
        self.backgroundColor = UIColor.white
        //sensitivity display
        sensitivity_display.position = CGPoint(x: 0, y: 300)
        sensitivity_display.fontColor = SKColor.red
        sensitivity_display.fontSize = 80
        
        addChild(sensitivity_display)
        
        spawn_delay()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //spawn_rectangles()
        print("hi mel :)")
        
//        for touch in touches {
//            print(touch.force)
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //print(touch.force)
            
            if (touch.location(in: self).x > 0 ) {
                sensitivity_display.text = String(describing: touch.force)
                print("right")
            }

            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
