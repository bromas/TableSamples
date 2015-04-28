//
//  AppNetStoryCell.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/21/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import BCCoalescing
import Architect

class AppNetStoryCell: UITableViewCell {
  
  @IBOutlet var avatarView: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var postLabel: UILabel!
  
  var imageDownloadRegistration: BCRegistrationToken?

  
  var imageFilter: (String) -> Bool = { identifier in return true }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func updateAvatarIcon(image: UIImage?) -> Void {
    self.avatarView?.image = image
  }
  
  func updateAvatarIconAnimated(image: UIImage?) -> Void {
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      self.avatarView.alpha = 0.0
      return
      }) { (completed) -> Void in
        self.avatarView?.image = image
        UIView.animateWithDuration(0.1, animations: { () -> Void in
          self.avatarView.alpha = 1.0
          return
        })
    }
  }

}
