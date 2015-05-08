//
//  ApplicationViewController.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/27/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers
import UIKit

class ViewController : UIViewController {
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let controller = segue.destinationViewController as! ColorViewController
    if segue.identifier == "Animating" {
      controller.configureWithColor(randomColor())
      controller.setStrategy(AnimatingStrategy(color: randomColor()))
    } else if segue.identifier == "Moveable" {
      controller.configureWithColor(randomColor())
      controller.setStrategy(MovableStrategy(color: randomColor()))
    }
  }
}
