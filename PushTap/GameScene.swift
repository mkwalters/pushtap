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

    
    var left_sensitivity_display = SKLabelNode(text: "0")
    var left_push_or_tap =  ""
    var left_push_or_tap_display = SKLabelNode(text: "9")
    
    
    var right_sensitivity_display = SKLabelNode(text: "0")
    var right_push_or_tap =  ""
    var right_push_or_tap_display = SKLabelNode(text: "9")
    
    
    let left_bar = SKSpriteNode()
    
    var left_force = CGFloat(0)
    var right_force = CGFloat(0)
    
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
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        left_bar.position = CGPoint(x: 0, y: 0)
        left_bar.color = SKColor.gray
        left_bar.size = CGSize(width: screenWidth, height: 50)
        addChild(left_bar)
        
        
        
        // Get label node from scene and store it for use later
        self.backgroundColor = UIColor.gray
        //sensitivity display
        left_sensitivity_display.position = CGPoint(x: -200, y: 300)
        left_sensitivity_display.fontColor = SKColor.red
        left_sensitivity_display.fontSize = 80
        
        left_push_or_tap_display.position = CGPoint(x: -200, y: 400)
        left_push_or_tap_display.fontColor = SKColor.red
        left_push_or_tap_display.fontSize = 80
        
        addChild(left_push_or_tap_display)
        
        addChild(left_sensitivity_display)
        
        right_push_or_tap_display.position = CGPoint(x: 200, y: 400)
        right_push_or_tap_display.fontColor = SKColor.red
        right_push_or_tap_display.fontSize = 80
        
        addChild(right_push_or_tap_display)
        
        right_sensitivity_display.position = CGPoint(x: 200, y: 300)
        right_sensitivity_display.fontColor = SKColor.red
        right_sensitivity_display.fontSize = 80
        
        addChild(right_sensitivity_display)
        
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
                right_sensitivity_display.text = String(describing: round(touch.force))
                right_force = touch.force
                if ( touch.force >  (touch.maximumPossibleForce / 2.0) ) {
                    right_push_or_tap = "push"
                    right_push_or_tap_display.text = "push"
                } else {
                    right_push_or_tap = "tap"
                    right_push_or_tap_display.text = "tap"
                }
            } else {
                left_sensitivity_display.text = String(describing: round(touch.force))
                left_force = touch.force
                if ( touch.force >  (touch.maximumPossibleForce / 2.0) ) {
                    left_push_or_tap = "push"
                    left_push_or_tap_display.text = "push"
                } else {
                    left_push_or_tap = "tap"
                    left_push_or_tap_display.text = "tap"
                }
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
