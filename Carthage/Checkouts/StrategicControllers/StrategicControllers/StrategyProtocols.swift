//
//  StrategyProtocols.swift
//  StrategyPattern
//
//  Created by Brian Thomas on 2/27/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public protocol Strategy {
  
  func configureWithController(controller: StrategicActor?)
  
  func viewDidLoad()
  func viewWillAppear(animated: Bool)
  func viewDidAppear(animated: Bool)
  
  func viewDidLayoutSubviews()
  func viewWillLayoutSubviews()
  
  func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
  
  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
  
}

public protocol StrategicActor {
  
  func setStrategy (newStrategy :Strategy) -> Void
  
  func viewDidLoad()
  func viewWillAppear(animated: Bool)
  func viewDidAppear(animated: Bool)
  
  func viewDidLayoutSubviews()
  func viewWillLayoutSubviews()
  
  func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
  
  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
}
