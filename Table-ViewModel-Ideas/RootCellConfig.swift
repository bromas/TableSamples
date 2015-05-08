//
//  RootCellConfig.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/17/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import TableViewViewModel

class RootCellConfig: UIViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "cellNib",
      let destination = segue.destinationViewController as? SimpleSelectTable {
        let dataConfigured = TVMConfigurationManager.sharedInstance.configureNibCell(destination)
        
        dataConfigured.actionOnSelection = { table, _, viewModel, index in
          let post = (viewModel as! PostTableViewModel<AppNetPost>).objectAtIndex(index)
          UIAlertView(title: "Tapped", message: post.user.userName, delegate: .None, cancelButtonTitle: "Ok").show()
        }
        
    } else if segue.identifier == "cellStory",
      let destination = segue.destinationViewController as? SimpleSelectTable {
        let dataConfigured = TVMConfigurationManager.sharedInstance.configureStoryCell(destination)
        
        dataConfigured.actionOnSelection = { table, _, viewModel, index in
          let post = (viewModel as! PostTableViewModel<AppNetPost>).objectAtIndex(index)
          table.performSegueWithIdentifier("showNib", sender: .None)
        }
        
        dataConfigured.segueConfigurationBlock = { segue, _ in
          if segue.identifier == "showNib",
            let destination = segue.destinationViewController as? SimpleSelectTable {
              TVMConfigurationManager.sharedInstance.configureNibCell(destination)
          }
        }
    }
  }
  
}
