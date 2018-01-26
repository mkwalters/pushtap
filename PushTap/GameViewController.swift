//
//  GameViewController.swift
//  PushTap
//
//  Created by Mitchell Walters on 1/17/18.
//  Copyright © 2018 Mitchell Walters. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Firebase

class GameViewController: UIViewController {
    
    var interstitial: GADInterstitial!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuScene = StartMenu()
        //MenuScene.
        let skView = view as! SKView
        //        skView.showsFPS = true
        //        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //menuScene.scaleMode = .resizeFill
        //menuScene.inputViewController = self
        skView.presentScene(menuScene)
        skView.showsFPS = true
        skView.showsNodeCount = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAd), name: NSNotification.Name(rawValue: "showAd"), object: nil)
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        request.testDevices = ["25c0bcb0d1bc91ac3a3e7ff59a1216f7"]
        interstitial.load(request)

    }
    
    func foobar() {
        
    }
    
    @IBAction func showAd(_ sender: AnyObject) {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
