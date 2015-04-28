//
//  AppNetPostPostCellConfiguration.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/21/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import TableViewViewModel
import BCCoalescing

func appNetPostPostCellConfiguration(requestsManager: ANPostRequestsManager) -> CellConfiguration<AppNetPost> {
  
  var cellConfiguration = CellConfiguration<AppNetPost>(identifier: "postCell", nib: UINib(nibName: "AppNetPost", bundle: NSBundle.mainBundle()))
  
  cellConfiguration.configureBlock = { cell, post in
    let postCell = cell as! AppNetPostCell
    postCell.userNameLabel.text = post.user.userName
    postCell.postLabel.text = post.text
    
    postCell.imageFilter = { identifier in
      return post.user.userName == identifier
    }
    
    postCell.imageDownloadRegistration?.invalidate()
    let image = requestsManager.localImageForUser(post.user)
    switch image {
    case let .found(image):
      postCell.updateAvatarIcon(image)
    case let .mocked(image):
      postCell.updateAvatarIcon(image)
      
      postCell.imageDownloadRegistration = requestsManager.imageForUser(post.user) { downloadedImage in
        postCell.updateAvatarIconAnimated(downloadedImage)
      }
    }
  }
  
  return cellConfiguration
  
}


func appNetPostStoryboardCellConfiguration(requestsManager: ANPostRequestsManager) -> CellConfiguration<AppNetPost> {
  
  var cellConfiguration = CellConfiguration<AppNetPost>(identifier: "postCell")
  
  cellConfiguration.configureBlock = { cell, post in
    let postCell = cell as! AppNetStoryCell
    postCell.userNameLabel.text = post.user.userName
    postCell.postLabel.text = post.text
    
    postCell.imageFilter = { identifier in
      return post.user.userName == identifier
    }
    
    postCell.imageDownloadRegistration?.invalidate()
    let image = requestsManager.localImageForUser(post.user)
    switch image {
    case let .found(image):
      postCell.updateAvatarIcon(image)
    case let .mocked(image):
      postCell.updateAvatarIcon(image)
      
      postCell.imageDownloadRegistration = requestsManager.imageForUser(post.user) { downloadedImage in
        postCell.updateAvatarIconAnimated(downloadedImage)
      }
    }
  }
  
  return cellConfiguration
  
}