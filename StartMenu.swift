//
//  StartMenu.swift
//  
//
//  Created by Mitchell Walters on 1/24/18.
//

import Foundation
import SpriteKit
import SwiftyStoreKit


// this is probably where all constants should live. I think there are some sprinkled throughout the other classes
let ICON_SIZE = CGSize(width: 120, height: 120)

class StartMenu: SKScene {
    
    // these are the assets that i want to use
    // https://www.gameart2d.com/free-casual-game-button-pack.html
    
    
    
    var play_button = SKSpriteNode(imageNamed: "play_button")
    
    var remove_ads = SKLabelNode(text: "Remove ads")
    
    var title = SKLabelNode(text: "PUSHTAP")
    
    override func didMove(to view: SKView) {
        print("start menu")
        self.backgroundColor = SKColor.black
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = SCREEN_SIZE
        
        play_button.position = CGPoint(x: 0, y: -100)
        play_button.name = "play"
        
        play_button.size = ICON_SIZE
        addChild(play_button)
        
        title.position = CGPoint(x: 0, y: 325)
        title.color = SKColor.purple
        title.fontSize = 150
        
        addChild(title)
        
        remove_ads.position = CGPoint(x: 0, y: -400)
        remove_ads.fontColor = SKColor.red
        remove_ads.fontSize = 80
        remove_ads.name = "remove ads"
        addChild(remove_ads)
        
        
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
        
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if name == "play" {
                    let reveal = SKTransition.doorway(withDuration: 0.25)
                    self.view?.presentScene(GameScene(), transition: reveal)
                }
                
                if name == "remove ads" {
                    purchase_ad_removal()
                }

                
            }
        }
    }
    
}
