//
//  ANPostRequestManager.swift
//  Table-ViewModel-Ideas
//
//  Created by Brian Thomas on 4/17/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import UIKit
import Runes
import Argo
import Alamofire

enum ProvidedImage {
  case found(UIImage)
  case mocked(UIImage?)
}

class ANPostRequestsManager {
  
  let coalesce = BCCoalesce()
  var userIDIconMap: [String: UIImage] = [:]
  let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
  
  init () {
    coalesce.shouldPerformCallbacksOnMainThread = true
    coalesce.resultsInterpolator = { data in
      let target = data as! NSData
      return UIImage(data: target)
    }
  }
  
  func recentPosts(completion: ([AppNetPost]) -> Void) -> Void {
    Alamofire.request(.GET, "https://alpha-api.app.net/stream/0/posts/stream/global").responseArgoJSON({ _, _, json, _ in
      let result = AppNetPostsResponse.decode(json)?.posts ?? []
      completion(result)
    })
  }
  
  func localImageForUser(forUser: AppNetUser) -> ProvidedImage {
    let possibleImage = userIDIconMap[forUser.userID]
    if let foundImage = possibleImage {
      return .found(foundImage)
    }
    return .mocked(.None)
  }
  
  func imageForUser(forUser: AppNetUser, completion: (UIImage?) -> Void) -> BCRegistrationToken {
    
    return self.coalesce.addCallbackWithProgress({ (_) -> Void in }, andCompletion: { (data, _, error) -> Void in
      
      self.userIDIconMap[forUser.userID] = data as? UIImage
      completion(self.userIDIconMap[forUser.userID])
      
      }, forIdentifier: forUser.userID) { () -> Void in
        self.session.dataTaskWithURL(NSURL(string: forUser.avatarUrl)!, completionHandler: { (data, _, error) -> Void in
          self.coalesce.identifier(forUser.userID, completedWithData: data, andError: error)
        }).resume()
    }
  }
  
}