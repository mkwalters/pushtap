//
//  GameScene.swift
//  PushTap
//
//  Created by Mitchell Walters on 1/17/18.
//  Copyright © 2018 Mitchell Walters. All rights reserved.
//
let SCREEN_SIZE = CGSize(width: 750.0, height: 1334.0)

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    

    var left_sensitivity_display = SKLabelNode(text: "0")
    var left_push_or_tap =  ""
    var left_push_or_tap_display = SKLabelNode(text: "9")
    
    var left_finish_line = SKSpriteNode()
    var right_finish_line = SKSpriteNode()
    
    var pause = SKLabelNode(text: "pause")
    
    var score_report = SKLabelNode(text: "0")
    var restart = SKLabelNode()
    
    var STARTING_LEFT_SENSITIVITY_SLIDER_X = CGPoint(x: 0, y: 0)
    var STARTING_RIGHT_SENSITIVITY_SLIDER_X = CGPoint(x: 0, y: 0)
    
    var dead = false
    var score = 0.0
    var resume = SKLabelNode()
    var exit = SKLabelNode()
    
    var right_sensitivity_display = SKLabelNode(text: "0")
    var right_push_or_tap =  ""
    var right_push_or_tap_display = SKLabelNode(text: "9")
    
    
    let left_bar = SKSpriteNode()
    
    var left_force = CGFloat(0)
    var right_force = CGFloat(0)
    
    var rectangles :[SKSpriteNode] = [SKSpriteNode]()
    var obstacles :[SKSpriteNode] = [SKSpriteNode]()
    
    var generator = UIFeedbackGenerator()
    
    let pause_background = SKShapeNode(rectOf: CGSize(width: 650, height: 1100))
    
    var paused_game = false
    
    let restart_button = SKLabelNode(text: "RESTART")
    
    var emitter = SKEmitterNode()
    
    var score_background = SKSpriteNode(color: UIColor.black, size: CGSize(width: 100, height: 100))
    
    
    // we really hsould build more constants
    var left_sensitivity_slider = SKSpriteNode(color: SKColor.purple, size: CGSize(width: 20, height: 50))
    var right_sensitivity_slider = SKSpriteNode(color: SKColor.purple, size: CGSize(width: 20, height: 50))
    
    
    
    //I SWEAR TO GOD YOU NEED TO PUT CREDIT FOR THIS IMAGE IN THE CREDITS OR CHOOSE A DIFFERENT ONE
    //https://support.flaticon.com/hc/en-us/articles/207248209-How-I-must-insert-the-attribution-
    //Designed by Freepik from www.flaticon.com IN CREDITS
    //probably best to just find one under creative commons license
    //its worth noting that we probably not necessary to implement a credits page
    var pause_button = SKSpriteNode(imageNamed: "pause")
    
    
    
    func update_score(new_score: Double) {
        score_report.text = String(Int(new_score))
        
        if (Int(new_score) % 2) == 1 {
            score_report.fontColor = SKColor.blue
        } else {
            score_report.fontColor = SKColor.red
        }
    }
    
    
    func create_scene() {
        self.view?.isMultipleTouchEnabled = true
        
        
        pause_button.position = CGPoint(x: 0, y: 0)
        pause_button.scale(to: CGSize(width: pause_button.size.width * 1.8, height: pause_button.size.height * 1.8))
        //addChild(pause_button)
        score_background.position = CGPoint(x: SCREEN_SIZE.width / 2.0 - 100, y: SCREEN_SIZE.height / 2.0 - 100)
        addChild(score_background)
        
        paused_game = false
        
        left_sensitivity_slider.color = SKColor.purple
        right_sensitivity_slider.color = SKColor.purple
        
        //left_sensitivity_slider.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        pause_button.position = CGPoint(x: -1 * SCREEN_SIZE.width / 2.0 + 100, y: SCREEN_SIZE.height / 2.0 - 100)
        pause_button.name = "pause"
        // the high z position just ensures that the ui is always at the top level
        pause_button.zPosition = 1000000
        addChild(pause_button)
        
        
        emitter.particlePosition = CGPoint(x: 0, y: 0)
        emitter.particleBirthRate = 1.0
        emitter.numParticlesToEmit = 1000
        emitter.targetNode = self.scene
        addChild(emitter)
        
        
        //score_report.position = CGPoint(x: SCREEN_SIZE.width / 2.0 - 100, y: SCREEN_SIZE.height / 2.0 - 100)
        score_report.position = CGPoint(x: 0, y: 0)
        score_report.fontSize = 70
        score_report.fontColor = SKColor.red
        score_report.horizontalAlignmentMode = .center
        score_report.verticalAlignmentMode = .center
        score_background.addChild(score_report)
        
        self.size = SCREEN_SIZE
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        restart_button.fontColor = SKColor.green
        restart_button.position = CGPoint(x: 0, y: 0)
        restart_button.fontSize = 70
        restart_button.name = "restart"
        score = 0
        
        
        
        let screenSize = UIScreen.main.bounds
        //let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        left_finish_line = SKSpriteNode(color: UIColor.black, size: CGSize(width: 275, height: 50.0))
        left_finish_line.position = CGPoint(x:  -200, y: 3 * screenHeight / -4)
        left_finish_line.zPosition = 100
        //left_finish_line.anchorPoint = CGPoint(x: 0, y: 0.5)
        STARTING_LEFT_SENSITIVITY_SLIDER_X = CGPoint(x: -1 * left_finish_line.size.width / 2 , y: 0)
        STARTING_RIGHT_SENSITIVITY_SLIDER_X = CGPoint(x: -1 * left_finish_line.size.width / 2 , y: 0)
        //Instead of adding child nodes to the sprite node whose anchorPoint got changed, use a common parent node (SKNode). Add the sprite node to the parent node
        
        
        
        left_sensitivity_slider.position = STARTING_LEFT_SENSITIVITY_SLIDER_X
        left_sensitivity_slider.zPosition = 10000
        
        right_sensitivity_slider.position = STARTING_RIGHT_SENSITIVITY_SLIDER_X
        right_sensitivity_slider.zPosition = 10000
        
        addChild(left_finish_line)
        left_finish_line.addChild(left_sensitivity_slider)
        
        
        right_finish_line = SKSpriteNode(color: UIColor.black, size: CGSize(width: 275, height: 50.0))
        right_finish_line.position = CGPoint(x:  200, y: 3 * screenHeight / -4)
        right_finish_line.zPosition = 100
        addChild(right_finish_line)
        right_finish_line.addChild(right_sensitivity_slider)
        
        
        
        
        // Get label node from scene and store it for use later
        
        let dimming_magnitude = 254
        self.backgroundColor = SKColor(red: CGFloat(255 - dimming_magnitude), green: CGFloat(255 - dimming_magnitude), blue: CGFloat(255 - dimming_magnitude), alpha: 1.0)
        
        //sensitivity display
        left_sensitivity_display.position = CGPoint(x: -200, y: 300)
        left_sensitivity_display.fontColor = SKColor.red
        left_sensitivity_display.fontSize = 80
        
        left_push_or_tap_display.position = CGPoint(x: -200, y: 400)
        left_push_or_tap_display.fontColor = SKColor.red
        left_push_or_tap_display.fontSize = 80
        
//        addChild(left_push_or_tap_display)
//
//        addChild(left_sensitivity_display)
        
        right_push_or_tap_display.position = CGPoint(x: 200, y: 400)
        right_push_or_tap_display.fontColor = SKColor.red
        right_push_or_tap_display.fontSize = 80
        
        //addChild(right_push_or_tap_display)
        
        right_sensitivity_display.position = CGPoint(x: 200, y: 300)
        right_sensitivity_display.fontColor = SKColor.red
        right_sensitivity_display.fontSize = 80
        
        //addChild(right_sensitivity_display)
        
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
        
        rectangle.name = "untouched" // this is kind of hacky. we might just want a class soon
        obstacle.name = "untouched"

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
        self.view?.presentScene(gameScene, transition: reveal)
        
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
    
    
    func resume_game() {
        paused_game = false
        pause_background.removeFromParent()
        resume_obstacles_and_rectangles()
    }
    
    
    func resume_obstacles_and_rectangles() {
        isPaused = false
        for obstacle in obstacles {
            obstacle.isPaused = false
        }
        
        for rectangle in rectangles {
            rectangle.isPaused = false
        }
    }
    
    
    func pause_obstacles_and_rectangles() {
        isPaused = true
        for obstacle in obstacles {
            obstacle.isPaused = true
        }
        
        for rectangle in rectangles {
            rectangle.isPaused = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //spawn_rectangles()
        //print("hi mel :)")
        //print(self.size)
        vibrateWithHaptic()
        
        
        for touch in touches {

            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            
            if let name = touchedNode.name {
                
                if name == "restart" {
                    print("trying to restart")
                    restart_scene()
                }

                
                
                if name == "pause" {
                    
                    if paused_game == false && dead == false {
                        
                        pause_obstacles_and_rectangles()
                        
                        paused_game = true
                    
                        pause_background.position = CGPoint(x: 0, y: 0)
                        pause_background.zPosition = 999999998
                        pause_background.fillColor = SKColor.black
                        
                        
                        
                        resume = SKLabelNode(text: "Resume")
                        resume.position = CGPoint(x: 0, y: 200)
                        resume.fontName = "PressStart2P"
                        resume.fontSize = 70
                        resume.fontColor = SKColor.blue
                        resume.name = "resume"
                        resume.zPosition = 999999999
                        
                        restart = SKLabelNode(text: "Restart")
                        restart.position = CGPoint(x: 0, y: 0)
                        restart.fontName = "PressStart2P"
                        restart.fontSize = 70
                        //                restart.fontColor = blue
                        restart.name = "restart"
                        restart.zPosition = 999999999
                        
                        
                        exit = SKLabelNode(text: "Exit")
                        exit.position = CGPoint(x: 0, y: -200)
                        exit.fontName = "PressStart2P"
                        exit.fontSize = 60
                        exit.fontColor = SKColor.blue
                        exit.name = "exit"
                        exit.zPosition = 999999999
                        
                        //paused_game = true
                        
                        self.addChild(pause_background)
                        pause_background.addChild(resume)
                        pause_background.addChild(exit)
                        pause_background.addChild(restart)
                        
                    }
                }
                
                if touchedNode.name == "resume" {
                    print("trying to resume")
                    
                    resume_game()
                }
                
                if touchedNode.name == "restart" {
                    print("tring to restart")
                    
                }
                if touchedNode.name == "exit" {
                    print("trying to exit")
                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
                    self.view?.presentScene(StartMenu(), transition: reveal)
                }
                
                
            }
            
        }
        
        
        
//        for touch in touches {
//            print(touch.force)
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dead == false && paused_game == false {
            print(touches.count)
        
        for touch in touches {
//            var touching_left = false
//            var touching_right = false
            
            //print(touch.force)
            //print(touches.count)
            
            if (touch.location(in: self).x > 0 ) {
                //touching_right = true
                right_sensitivity_display.text = String(describing: round(touch.force))
                right_force = touch.force
                
                right_sensitivity_slider.position.x = (STARTING_RIGHT_SENSITIVITY_SLIDER_X.x + ( (right_force) * right_finish_line.size.width ) / touch.maximumPossibleForce)
                
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
                
                left_sensitivity_slider.position.x = STARTING_LEFT_SENSITIVITY_SLIDER_X.x + ( (left_force) * left_finish_line.size.width ) / touch.maximumPossibleForce
                
                
                
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
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if (touch.location(in: self).x >= 0) {
                right_finish_line.color = SKColor.black
                right_force = 0
            } else {
                left_finish_line.color = SKColor.black
                left_force = 0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    func stop_all_actions() {
        for obstacle in obstacles {
            obstacle.removeAllActions()
        }
        
        for rectangle in rectangles {
            rectangle.removeAllActions()
        }
        
        
        self.removeAllActions()
    }
    
    
    
    func report_death() {
        
        if dead == false {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAd"), object: nil)
        
            let death_report = SKLabelNode(text: "YOU DIED")
            death_report.position = CGPoint(x: 0, y: 200)
            death_report.fontColor = SKColor.red
            death_report.fontSize = 100
            
            addChild(restart_button)
            stop_all_actions()
            
            //toggle this to trigger reports
            addChild(death_report)
            
            dead = true
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        
        
        for obstacle in obstacles {
            
            // theres a few conditions to check here
            // i have a feeling that this could be written really cleanly if we ask smart questions
            
            if left_finish_line.intersects(obstacle)  && (left_finish_line.color != obstacle.color) {
                report_death()
            }
            if right_finish_line.intersects(obstacle)  && (right_finish_line.color != obstacle.color) {
                report_death()
            }
            
            // be careful mixing this logic because they should hit and and lose if they press
            //the untouched logic could fuck things
            if left_finish_line.intersects(obstacle) && ( left_finish_line.color == obstacle.color && right_finish_line.color == obstacle.color) {
                if obstacle.name == "untouched" {
                    score += 0.5 // this is really hacky and shitty
                    // i dont know why but its incrementing score twice
                    //this seems really consistent
                    obstacle.name = "touched"
                    update_score(new_score: score)
                    
                }
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
