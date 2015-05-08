//
//  DrawSpiralStrategy.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 2/28/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers

struct SpiralMove {
  let direction : SpiralDirection
  let magnitude : CGFloat
}

enum SpiralDirection {
  case Up
  case Right
  case Down
  case Left
}

typealias DrawSpiralStrategy = drawSpiralStrategey<Int>

class drawSpiralStrategey<T> : ControllerStrategy<ColorViewController> {
  override func viewDidLoad() {
    controller.actionOnButtonTap = {
//      controller.colorView
    }
  }
  
  func addLineToPath(path: UIBezierPath, lastMove: SpiralDirection) {
    
  }
}
