//
//  CellConfigTViewModel.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/17/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import Runes
import TableViewViewModel

class PostTableViewModel<T>: SimpleSelectTableViewModel {
  
  typealias T = AppNetPost
  
  var collection: [AppNetPost] = []
  var cellConfiguration: CellConfiguration<AppNetPost>?
  var requestManager: ANPostRequestsManager?
  var defaultEstimatedCellHeight: CGFloat = 64.0
  
  init() { }
  
  func estimatedRowHeight() -> CGFloat {
    return self.cellConfiguration?.estimatedHeight ?? self.defaultEstimatedCellHeight
  }
  
  func refreshData(completion: () -> Void) {
    requestManager?.recentPosts { posts in
      self.collection = posts
      completion()
    }
  }
  
  func numberOfItems() -> Int {
    return collection.count
  }
  
  func objectAtIndex(index: Int) -> AppNetPost {
    return collection[index]
  }
  
  func registerCellConfiguration(configuration: CellConfiguration<AppNetPost>) {
    cellConfiguration = configuration
  }
  
  func configureCell(cell: UITableViewCell, identifier: String, forIndexPath: Int) {
    let appNetPost = collection[forIndexPath]
    if identifier == cellConfiguration?.cellIdentifier {
      self.cellConfiguration?.configureBlock(cell, appNetPost)
    }
  }
  
  
}
