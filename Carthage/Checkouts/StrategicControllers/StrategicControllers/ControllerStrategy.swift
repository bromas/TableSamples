//
//  ControllerStrategy.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 10/22/14.
//  Copyright (c) 2014 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public class ControllerStrategy<T: StrategicActor> : Strategy {
  
   public var controller : T! {
    get {
      let found = configuredController as? T
      if let managed = found {
        return .Some(managed)
      }
      else {
        assertionFailure("You configured a controller with an invalid strategy for its type.")
        return .None
      }
    }
  }
  
  public var configuredController : StrategicActor?
  
  public init () { }
  
  public func configureWithController(controller: StrategicActor?) {
    configuredController = controller
  }
  
  public func viewDidLoad() { }
  
  public func viewWillAppear(animated: Bool) { }
  
  public func viewDidAppear(animated: Bool) { }
  
  public func viewDidLayoutSubviews() { }
  
  public func viewWillLayoutSubviews() { }
  
  public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) { }
  
  public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { }
  
  public func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    return true
  }
  
}
