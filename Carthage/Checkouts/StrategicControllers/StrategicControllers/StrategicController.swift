//
//  StrategicController.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/22/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public class StrategicController : UIViewController, StrategicActor {
  
  private var strategy :Strategy?
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public func setStrategy (newStrategy :Strategy) -> Void {
    strategy = newStrategy
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    strategy?.configureWithController(self)
    strategy?.viewDidLoad()
  }
  
  override public func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    strategy?.viewWillAppear(animated)
  }
  
  override public func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    strategy?.viewDidAppear(animated)
  }
  
  override public func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    strategy?.viewDidLayoutSubviews()
  }
  
  override public func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    strategy?.viewWillLayoutSubviews()
  }
  
  override public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    strategy?.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
  }
  
  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    strategy?.prepareForSegue(segue, sender: sender)
  }
  
  public override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    var shouldPerform = strategy?.shouldPerformSegueWithIdentifier(identifier, sender: sender)
    if let answer = shouldPerform {
      if !answer { return false }
    }
    return true
  }
  
}