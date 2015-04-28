//
//  RootObserving.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/22/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import TableViewViewModel

class RootObserving: UIViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "cellNib",
      let destination = segue.destinationViewController as? SimpleSelectTable {
        
    }
  }
  
}
