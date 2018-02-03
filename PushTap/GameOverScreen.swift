//
//  GameOverScreen.swift
//  PushTap
//
//  Created by Mitchell Walters on 2/1/18.
//  Copyright © 2018 Mitchell Walters. All rights reserved.
//


import UIKit
import Foundation
import SpriteKit
import SwiftyStoreKit

class GameOverScreen: SKScene {
    
    var play_button = SKLabelNode(text: "PLAY")
    
    var remove_ads = SKLabelNode(text: "Remove ads")
    
    var title = SKLabelNode(text: "PUSHTAP")
    
    var game_over_label = SKLabelNode(text: "GAME OVER")
    
    override func didMove(to view: SKView) {
        
        self.size = SCREEN_SIZE
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        for _ in 0...100 {
            print("im trying to show the game over screen")
        }
        
        game_over_label.position = CGPoint(x: 0, y: 300)
        game_over_label.fontColor = SKColor.red
        game_over_label.fontSize = 100
        addChild(game_over_label)
        
        let dimming_magnitude = 254
        self.backgroundColor = SKColor(red: CGFloat(255 - dimming_magnitude), green: CGFloat(255 - dimming_magnitude), blue: CGFloat(255 - dimming_magnitude), alpha: 1.0)
    }
    
    func purchase_ad_removal() {
        SwiftyStoreKit.purchaseProduct("54321", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for _ in touches {
            
//            let positionInScene = touch.location(in: self)
//            let touchedNode = atPoint(positionInScene)
//            if let name = touchedNode.name
//            {
//                if name == "play" {
//                    let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.25)
//                    self.view?.presentScene(GameScene(), transition: reveal)
//                }
//
//                if name == "remove ads" {
//                    purchase_ad_removal()
//                }
//            }
        }
    }
    
}
