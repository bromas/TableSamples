//
//  RandomGenerators.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 2/27/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

func randomColor () -> UIColor {
  let red = (CGFloat(arc4random()) % 255) / 255
  let green = (CGFloat(arc4random()) % 255) / 255
  let blue = (CGFloat(arc4random()) % 255) / 255
  return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func randomCoords () -> CGPoint {
  let x = (CGFloat(arc4random()) % 300) + 30
  let y = (CGFloat(arc4random()) % 400) + 60
  return CGPointMake(x, y)
}
