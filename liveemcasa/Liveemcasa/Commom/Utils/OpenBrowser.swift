//
//  OpenBrowser.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

class OpenBrowser {
  
  static let sharedInstance = OpenBrowser()
  
  private init() { }
  
  // MARK: - Public functions
  
  /// Configure actionSheet, all parameters are optional and only parameters with values will be shown
  ///
  /// - Parameters:
  ///   - title: title of actionSheet. Can be nil
  ///   - message: subtitle of actionSheet. Can be nil
  ///   - url: url of actionSheet. Can be nil
  func openBrowser(viewController : UIViewController, title : String, message : String, url: String) {
    
    let sharedApplication = UIApplication.shared
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .actionSheet)
    
    let safariURL = URL(string: url)
    let youtubeURL = URL(string: String(format: "youtube://%@", url))
    
    let safariAction = UIAlertAction(title: "Safari", style: .default) { (_) in
      UIApplication.shared.open(safariURL!, options: [:], completionHandler: nil)
    }
    
    let youtubeAction = UIAlertAction(title: "Youtube", style: .default) { (_) in
      UIApplication.shared.open(youtubeURL!, options: [:], completionHandler: nil)
    }
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
    
    if sharedApplication.canOpenURL(safariURL!) {
      alert.addAction(safariAction)
    }
    
    if url.contains("youtube") && sharedApplication.canOpenURL(youtubeURL!) {
      alert.addAction(youtubeAction)
    }

    alert.addAction(cancelAction)
    
    viewController.present(alert, animated: true, completion: nil)
  }
}
