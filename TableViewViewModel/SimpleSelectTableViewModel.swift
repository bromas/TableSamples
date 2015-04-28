//
//  SimpleSelectTableViewModel.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/24/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public protocol SimpleSelectTableViewModel {
  
  func estimatedRowHeight() -> CGFloat
  func numberOfItems() -> Int
  
  func refreshData(completion: () -> Void) -> Void
  func configureCell(cell: UITableViewCell, identifier: String, forIndexPath: Int)
  
}
