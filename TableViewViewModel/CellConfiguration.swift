//
//  CellConfiguration.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/24/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public protocol CellRegistrationConfiguration {
  func registerToTable(table: UITableView) -> String
}

public enum CellConfigurationType {
  case Nib
  case Class
  case Storyboard
}

public class CellConfiguration<T>: CellRegistrationConfiguration {
  
  public var cellIdentifier: String = ""
  var cell: UINib?
  var cellClass: AnyClass = UITableViewCell.self
  var type: CellConfigurationType = .Storyboard
  
  public init(identifier: String) {
    cellIdentifier = identifier
    type = .Storyboard
  }
  
  public init(identifier: String, nib: UINib) {
    cellIdentifier = identifier
    cell = nib
    type = .Nib
  }
  
  public init(identifier: String, klass: AnyClass) {
    cellIdentifier = identifier
    cellClass = klass
    type = .Class
  }
  
  public var estimatedHeight: CGFloat?
  
  public var configureBlock: (UITableViewCell, T) -> Void = { cell, model in
    return
  }
  
  public func registerToTable(table: UITableView) -> String {
    switch self.type {
    case .Nib:
      if let nib = self.cell {
        table.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
      }
    case .Class:
      table.registerClass(cellClass, forCellReuseIdentifier: cellIdentifier)
    case .Storyboard:
      assert(true)
    }
    return cellIdentifier
  }
}
