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

enum ProvidedImage {
  case found(UIImage)
  case mocked(UIImage?)
}

class ANPostRequestsManager {
  
  let streamURL = "https://alpha-api.app.net/stream/0/posts/stream/global"
  
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
    self.session.dataTaskWithURL(NSURL(string: streamURL)!, completionHandler: { (data, _, err) -> Void in
      let result: [AppNetPost]
      switch err {
      case let .Some(error):
        result = []
      case .None:
        let json = JSONValue.parse(NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)!)
        result = AppNetPostsResponse.decode(json)?.posts ?? []
      }
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completion(result)
      })
    }).resume()
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
      
//      could handle errors here but they would happen for each requester.
      self.userIDIconMap[forUser.userID] = data as? UIImage
      completion(self.userIDIconMap[forUser.userID])
      
      }, forIdentifier: forUser.userID) { () -> Void in
        self.session.dataTaskWithURL(NSURL(string: forUser.avatarUrl)!, completionHandler: { (data, _, err) -> Void in
          switch err {
          case let .Some(error):
//            handle error once here and push dummy data into completion
            self.coalesce.identifier(forUser.userID, completedWithData: NSData(), andError: error)
          case .None:
            self.coalesce.identifier(forUser.userID, completedWithData: data, andError: .None)
          }
        }).resume()
    }
  }
  
}