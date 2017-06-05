//
//  FirstController.swift
//  test1
//
//  Created by Michal Lučanský on 18.5.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import UIKit
import WatchKit

class FirstController: WKInterfaceController {
    
    

    @IBAction func gameStart() {
       
      pushController(withName: "GameScene", context: nil)
      
        
    }

    }
