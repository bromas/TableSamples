//
//  TVMConfigurationManager.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/21/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import TableViewViewModel

private let _TVMConfigurationManagerSharedInstance = TVMConfigurationManager()

class TVMConfigurationManager {
  class var sharedInstance: TVMConfigurationManager {
    return _TVMConfigurationManagerSharedInstance
  }
  
  var postDataManager = ANPostRequestsManager()
  
  func configureNibCell(destination: SimpleSelectTable) -> SimpleSelectTable {
    
//    Create/Select a TableViewModel
    let tvm = PostTableViewModel<AppNetPost>()
    tvm.requestManager = postDataManager
    
//    Create a Cell Configuration that bridges a nib for the tableview and the model for the table view model.
    var cellConfiguration = appNetPostPostCellConfiguration(postDataManager)
    
//    Glue it all together
    tvm.registerCellConfiguration(cellConfiguration)
    destination.registerCellConfiguration(cellConfiguration)
    
    destination.configure(viewModel: tvm)
    return destination
  }
  
  func configureStoryCell(destination: SimpleSelectTable) -> SimpleSelectTable {
    let tvm = PostTableViewModel<AppNetPost>()
    tvm.requestManager = postDataManager
    
    var cellConfiguration = appNetPostStoryboardCellConfiguration(postDataManager)
    
    tvm.registerCellConfiguration(cellConfiguration)
    destination.registerCellConfiguration(cellConfiguration)
    
    destination.configure(viewModel: tvm)
    return destination
  }
  
}