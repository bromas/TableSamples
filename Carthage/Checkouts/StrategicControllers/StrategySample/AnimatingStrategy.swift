//
//  BlueStrategy.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/22/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers
import UIKit

typealias AnimatingStrategy = animatingStrategy<Int>

class animatingStrategy<T> : ControllerStrategy<ColorViewController> {
  
  let startingColor : UIColor
  
  init(color: UIColor) {
    startingColor = color
    super.init()
  }
  
  override func viewDidLoad() {
    
    controller.view.backgroundColor = startingColor

    controller.actionOnButtonTap = { [unowned self] in
      let newColor = randomColor()
      let animation = self.controllerBackgroundAnimationToColor(newColor)
      self.controller.view.layer.removeAllAnimations()
      self.controller.view.layer.addAnimation(animation, forKey: "backgroundChange")
      self.controller.view.backgroundColor = newColor
    }
  }
  
  func controllerBackgroundAnimationToColor(newColor: UIColor) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "backgroundColor")
    animation.fromValue = (self.controller.view.layer.presentationLayer() as! CALayer).backgroundColor
    animation.duration = 1.0
    animation.toValue = newColor.CGColor
    return animation
  }
  
}
