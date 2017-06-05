//
//  InterfaceController.swift
//  RoundOng Extension
//
//  Created by Michal Lučanský on 16.5.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController,WKCrownDelegate {

    @IBOutlet var skInterface: WKInterfaceSKScene!
    @IBAction func ggg(_ sender: WKTapGestureRecognizer) {
        
        
        pushController(withName: "FirstController", context: nil)
            }
    
    

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        // Configure interface objects here.
        if let scene = GameScene(fileNamed: "GameScene") {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.skInterface.presentScene(scene)
            
            // Use a value that will maintain a consistent frame rate
            self.skInterface.preferredFramesPerSecond = 20
        }
        
    }
    
       
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
   
       
        
        if rotationalDelta > 0 {
            GameScene.angle += 0.08
        }else if rotationalDelta < 0{
            GameScene.angle -= 0.08
        }else if rotationalDelta == 0{
        
        
        }
    }
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        crownSequencer.delegate = self
        crownSequencer.focus()
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
