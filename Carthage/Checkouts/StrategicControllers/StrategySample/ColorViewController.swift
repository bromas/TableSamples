//
//  ColorChangeController.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/22/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import StrategicControllers
import UIKit

class SomeModel {
  
  var modelName = "Name"
  var modelDetail = "Detail"
  
}

class ColorViewController : StrategicController {
  
  @IBAction func buttonTap () { actionOnButtonTap() }
  var actionOnButtonTap: (() -> Void) = {
    UIAlertView(title: "Default", message: "Unconfigured, default behavior can be performed.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles:"Ok").show()
  }
  
  @IBAction func resignModal () {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBOutlet var colorView : UIView!
  var backgroundColor :UIColor = UIColor.lightGrayColor()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  required override init() {
    super.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    colorView.backgroundColor = backgroundColor
  }
  
  func configureWithColor(color :UIColor) {
    backgroundColor = color
    configureViewForColor(backgroundColor)
  }
  
  func configureViewForColor(color: UIColor) {
    if self.isViewLoaded() {
      colorView.backgroundColor = color
    }
  }
  
}
