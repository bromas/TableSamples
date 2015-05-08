//
//  CompositeStrategy.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 4/13/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public class CompositeStrategy<T: StrategicActor> : Strategy {
  
  private var strategies = [String: ControllerStrategy<T>]()
  private var strategyKeys = [String]()
  
  public subscript(key: String) -> ControllerStrategy<T>? {
    
    get {
      return strategies[key]
    }
    
    set {
      if let nonOptional = newValue {
        strategies[key] = nonOptional
        strategyKeys.append(key)
      }
      else {
        strategies.removeValueForKey(key)
        strategyKeys = strategyKeys.filter { $0 != key }
      }
    }
    
  }
  
  public var configuredController : StrategicActor?
  
  public init () { }
  
  public func configureWithController(controller: StrategicActor?) {
    self.configuredController = controller
    for key in strategyKeys { strategies[key]?.configureWithController(self.configuredController) }
  }
  
  public func viewDidLoad() {
    for key in strategyKeys {
      strategies[key]?.viewDidLoad()
    }
  }
  
  public func viewWillAppear(animated: Bool) {
    for key in strategyKeys {
      strategies[key]?.viewWillAppear(animated)
    }
  }
  
  public func viewDidAppear(animated: Bool) {
    for key in strategyKeys {
      strategies[key]?.viewDidAppear(animated)
    }
  }
  
  public func viewDidLayoutSubviews() {
    for key in strategyKeys {
      strategies[key]?.viewDidLayoutSubviews()
    }
  }
  
  public func viewWillLayoutSubviews() {
    for key in strategyKeys {
      strategies[key]?.viewWillLayoutSubviews()
    }
  }
  
  public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    for key in strategyKeys {
      strategies[key]?.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
  }
  
  public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    for key in strategyKeys { strategies[key]?.prepareForSegue(segue, sender: sender) }
  }
  
  public func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    for key in strategyKeys {
      var shouldPerform = strategies[key]?.shouldPerformSegueWithIdentifier(identifier, sender: sender)
      if let answer = shouldPerform {
        if !answer { return false }
      }
    }
    return true
  }
}
