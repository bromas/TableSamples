//
//  RedStrategy.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/22/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers
import UIKit

typealias MovableStrategy = movableStrategy<Int>

class movableStrategy<T> : ControllerStrategy<ColorViewController> {
  
  var view : UIView = UIView()
  var leftConstraint : NSLayoutConstraint?
  var topConstraint : NSLayoutConstraint?
  let startingColor : UIColor
  
  init(color: UIColor) {
    startingColor = color
    super.init()
  }
  
  override func viewDidLoad() {
    addViewAboveColorView()
    view.backgroundColor = startingColor
    
    controller.actionOnButtonTap = { [unowned self] in
      let newCoords = randomCoords()
      let animation = self.viewFrameAnimationPosition(newCoords)
      self.view.layer.removeAllAnimations()
      self.view.layer.addAnimation(animation, forKey: "newCoords")
    }
  }
  
  func addViewAboveColorView () {
    let container = controller.colorView
    if let found = container {
      view.setTranslatesAutoresizingMaskIntoConstraints(false)
      controller.view.addSubview(view)
      let constraint1 = NSLayoutConstraint.constraintsWithVisualFormat("V:[view(60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": view]).first! as! NSLayoutConstraint
      let constraint2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[view]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": view]).first! as! NSLayoutConstraint
      let constraint3 = NSLayoutConstraint.constraintsWithVisualFormat("H:[view(60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": view]).first! as! NSLayoutConstraint
      let constraint4 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-\((controller.view.frame.size.width - 60) / 2)-[view]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": view]).first! as! NSLayoutConstraint
      controller.view.addConstraint(constraint1)
      controller.view.addConstraint(constraint2)
      controller.view.addConstraint(constraint3)
      controller.view.addConstraint(constraint4)
      leftConstraint = constraint4
      topConstraint = constraint2
    }
  }
  
  func viewFrameAnimationPosition(newPosition: CGPoint) -> CABasicAnimation {
    CATransaction.begin()
    let animation = CABasicAnimation(keyPath: "position")
    let newCoords = randomCoords()
    let oldValue = (view.layer.presentationLayer() as! CALayer).position
    animation.fromValue = NSValue(CGPoint: oldValue)
    animation.duration = 0.6
    animation.toValue = NSValue(CGPoint: newCoords)
    CATransaction.setCompletionBlock { () -> Void in
      
    }
    CATransaction.commit()
    leftConstraint?.constant = newCoords.x - 30
    topConstraint?.constant = newCoords.y - 30
    return animation
  }
}
