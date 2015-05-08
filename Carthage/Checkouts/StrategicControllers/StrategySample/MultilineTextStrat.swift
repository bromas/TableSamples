//
//  MultilineTextStrat.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/31/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers

//@objc protocol MultilineTextController {
//    
//    var view: UIView {get set}
//    func labelsNeedingSized() -> [UILabel]
//    
//}
//
//class MultilineGeneric : MultilineTextController {
//    var view :UIView = UIView()
//    init() { }
//    func labelsNeedingSized() -> [UILabel] { return [UILabel]() }
//}
//
//class MultilineTextStrat : ControllerStrategy {
//   
//    override func viewDidLayoutSubviews() {
//        let labels = textController.labelsNeedingSized()
//        for label in labels {
//            label.preferredMaxLayoutWidth = label.frame.size.width
//            textController.view.layoutIfNeeded()
//        }
//    }
//    
//}
