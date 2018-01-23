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

    let SCREEN_SIZE = CGSize(width: 750.0, height: 1334.0)
    var left_sensitivity_display = SKLabelNode(text: "0")
    var left_push_or_tap =  ""
    var left_push_or_tap_display = SKLabelNode(text: "9")
    
    var left_finish_line = SKSpriteNode()
    var right_finish_line = SKSpriteNode()
    
    
    var dead = false
    
    
    var right_sensitivity_display = SKLabelNode(text: "0")
    var right_push_or_tap =  ""
    var right_push_or_tap_display = SKLabelNode(text: "9")
    
    
    let left_bar = SKSpriteNode()
    
    var left_force = CGFloat(0)
    var right_force = CGFloat(0)
    
    var rectangles :[SKSpriteNode] = [SKSpriteNode]()
    var obstacles :[SKSpriteNode] = [SKSpriteNode]()
    
    var generator = UIFeedbackGenerator()
    
    
    let restart_button = SKLabelNode(text: "RESTART")
    
    
    func create_scene() {
        self.view?.isMultipleTouchEnabled = true
        
        self.size = SCREEN_SIZE
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        restart_button.fontColor = SKColor.green
        restart_button.position = CGPoint(x: 0, y: 500)
        restart_button.fontSize = 70
        restart_button.name = "restart"
        
        
        addChild(restart_button)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        left_finish_line = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenWidth / 2, height: 50.0))
        left_finish_line.position = CGPoint(x:  screenWidth / -2, y: 3 * screenHeight / -4)
        left_finish_line.zPosition = 100
        addChild(left_finish_line)
        
        right_finish_line = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenWidth / 2, height: 50.0))
        right_finish_line.position = CGPoint(x:  screenWidth / 2, y: 3 * screenHeight / -4)
        right_finish_line.zPosition = 100
        addChild(right_finish_line)
        
        
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
    
    func spawn_rectangles() {
        spawn_rectangle(side: "left")
        spawn_rectangle(side: "right")
    }
    
    func spawn_delay() {
        
        let spawn = SKAction.run({
            
            self.spawn_rectangles()
            
        })
        let delay = SKAction.wait(forDuration: 2.0)
        
        let spawn_delay = SKAction.group([spawn, delay])
        
        let repeat_forever = SKAction.repeatForever(spawn_delay)
        
        run(repeat_forever)
    }
    
    
    func spawn_rectangle(side: String) {
        
        let diceroll = arc4random() % 2
        var color = SKColor.black
        
        let obstacle = SKSpriteNode(color: UIColor.black, size: CGSize(width: 800, height: 30))
        obstacle.position = CGPoint(x: 0, y: 1050)
        addChild(obstacle)
        
        if (diceroll == 0) {
            color = SKColor.blue
        } else {
            color = SKColor.red
        }
        
        let drop_down = SKAction.moveBy(x: 0, y: -1800, duration: 4.5)
        
        let delete_self = SKAction.run {
            self.rectangles[0].removeFromParent()
            self.rectangles.remove(at: 0)
            self.obstacles[0].removeFromParent()
            self.obstacles.remove(at: 0)
        }
        
        let drop_down_and_delete = SKAction.sequence([drop_down, delete_self])
        
        let rectangle = SKSpriteNode(color: color, size: CGSize(width: 150, height: 150))
        rectangle.run(drop_down_and_delete)
        rectangle.position = CGPoint(x: 0, y: 700)
        //dont delete self for obstacles
        obstacle.run(drop_down)
        if (side == "left") {
            rectangle.position.x -= 200
        } else {
            rectangle.position.x += 200
        }
        obstacles.append(obstacle)
        rectangles.append(rectangle)
        addChild(rectangle)

    }
    
    override func didMove(to view: SKView) {
        create_scene()
    }
    
    func restart_scene() {
        
        removeAllActions()
        removeAllChildren()
        for obstacle in obstacles {
            obstacle.removeAllActions()
        }
        for rectangle in rectangles {
            rectangle.removeAllActions()
        }
        obstacles = []
        rectangles = []
        
        
        let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
        let gameScene = GameScene()
        self.view?.presentScene(gameScene)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    func vibrateWithHaptic() {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    
    generator.impactOccurred()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //spawn_rectangles()
        print("hi mel :)")
        print(self.size)
        vibrateWithHaptic()
        
        for touch in touches {

            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            
            if let name = touchedNode.name {
                
                if name == "restart" {
                    print("trying to restart")
                    restart_scene()
                    
                    
                }
                
            }
            
        }
        
        
        
//        for touch in touches {
//            print(touch.force)
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        for touch in touches {
//            var touching_left = false
//            var touching_right = false
            
            //print(touch.force)
            //print(touches.count)
            
            if (touch.location(in: self).x > 0 ) {
                //touching_right = true
                right_sensitivity_display.text = String(describing: round(touch.force))
                right_force = touch.force
                if ( touch.force >  (touch.maximumPossibleForce / 2.0) ) {
                    right_push_or_tap = "push"
                    right_push_or_tap_display.text = "push"
                    right_finish_line.color = SKColor.red
                } else {
                    right_push_or_tap = "tap"
                    right_push_or_tap_display.text = "tap"
                    right_finish_line.color = SKColor.blue
                }
            } else {
                //touching_left = true
                left_sensitivity_display.text = String(describing: round(touch.force))
                left_force = touch.force
                if ( touch.force >  (touch.maximumPossibleForce / 2.0) ) {
                    left_push_or_tap = "push"
                    left_push_or_tap_display.text = "push"
                    left_finish_line.color = SKColor.red
                } else {
                    left_push_or_tap = "tap"
                    left_push_or_tap_display.text = "tap"
                    left_finish_line.color = SKColor.blue
                }
            }
            
//            if touching_left == false {
//                left_finish_line.color = SKColor.black
//            }
//            if touching_right == false {
//                right_finish_line.color = SKColor.black
//            }
//
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if (touch.location(in: self).x >= 0) {
                right_finish_line.color = SKColor.black
            } else {
                left_finish_line.color = SKColor.black
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func report_death() {
        
        if dead == false {
        
            let death_report = SKLabelNode(text: "YOU DIED")
            death_report.position = CGPoint(x: 0, y: 0)
            death_report.fontColor = SKColor.red
            death_report.fontSize = 100
            
            
            //toggle this to trigger reports
            addChild(death_report)
            
            dead = true
            
        }
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        
        
        for obstacle in obstacles {
            if left_finish_line.intersects(obstacle)  && (left_finish_line.color != obstacle.color) {
                report_death()
            }
            if right_finish_line.intersects(obstacle)  && (right_finish_line.color != obstacle.color) {
                report_death()
            }
        }
        
        for rectangle in rectangles {
            if left_finish_line.intersects(rectangle)  && (left_finish_line.color != rectangle.color) {
                report_death()
            }
            if right_finish_line.intersects(rectangle)  && (right_finish_line.color != rectangle.color) {
                report_death()
            }
        }
        
        
    }
}
