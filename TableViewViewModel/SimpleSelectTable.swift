//
//  SimpleSelectTable.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/24/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit

public class SimpleSelectTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  public var actionOnSelection: (table: SimpleSelectTable, cell: UITableViewCell, viewModel: SimpleSelectTableViewModel?, indexPath: Int) -> Void = { (table, tableViewModel, cell, index) in
    
  }
  
  public var segueConfigurationBlock: (segue: UIStoryboardSegue, sender: AnyObject?) -> Void = { segue, _ in
    
  }
  
  var tableController: UITableViewController?
  @IBOutlet var table: UITableView!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  var viewModel: SimpleSelectTableViewModel?
  var cellIdentifier: String = "cellIdentifier"
  var cellConfiguration: CellRegistrationConfiguration?
  
  public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    segueConfigurationBlock(segue: segue, sender: sender)
  }
  
  public func configure(#viewModel: SimpleSelectTableViewModel) {
    self.viewModel = viewModel
    if self.isViewLoaded() {
      table.reloadData()
    }
  }
  
  public func registerCellConfiguration(model: CellRegistrationConfiguration) {
    cellConfiguration = model
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    if let foundTable = table {
      cellIdentifier = cellConfiguration?.registerToTable(foundTable) ?? "cellIdentifer"
    } else {
      self.tableController = UITableViewController()
      self.tableController!.view.setTranslatesAutoresizingMaskIntoConstraints(false)
      self.tableController?.willMoveToParentViewController(self)
      self.view.addSubview(self.tableController!.view)
      self.addChildViewController(self.tableController!)
      self.tableController!.didMoveToParentViewController(self)
      
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": self.view, "table": self.tableController!.view]))
      self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": self.view, "table": self.tableController!.view]))
      
      self.table = self.tableController?.tableView
      cellIdentifier = cellConfiguration?.registerToTable(self.table) ?? "cellIdentifer"
      self.table.delegate = self
      self.table.dataSource = self
    }
    self.table.rowHeight = UITableViewAutomaticDimension
    self.table.estimatedRowHeight = viewModel?.estimatedRowHeight() ?? 60.0
    self.table.allowsSelection = true
    self.table.tableFooterView = UIView(frame: CGRectMake(0, 0, 0, 1))
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    indicator.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(indicator)
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[indicator]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": self.view, "indicator": indicator]))
    self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[indicator]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["view": self.view, "indicator": indicator]))
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    self.activityIndicator = indicator
    self.viewModel?.refreshData() { [weak self] () -> Void in
      self?.table.reloadData()
      self?.activityIndicator.stopAnimating()
      if let controller = self?.tableController {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        controller.refreshControl = refresh
      }
    }
  }
  
  func refresh() {
    self.viewModel?.refreshData() { [unowned self] () -> Void in
      self.table.reloadData()
      self.tableController?.refreshControl?.endRefreshing()
    }
  }
  
  // Data Source
  @objc public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.numberOfItems() ?? 1
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = table.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier")
    viewModel?.configureCell(cell, identifier: cellIdentifier, forIndexPath: indexPath.row)
    cell.frame =  CGRectMake(0, 0, CGRectGetWidth(self.table.frame), 90)
    cell.layoutIfNeeded()
    return cell
  }
  
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    actionOnSelection(table: self, cell: self.table.cellForRowAtIndexPath(indexPath)!, viewModel: self.viewModel, indexPath: indexPath.row)
    self.table.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}
